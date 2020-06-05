#!/usr/bin/env python3

import math

from PIL import Image

#LAB0 CODE

def get_pixel(image, x, y):
    '''This function gets a pixel value, given a column (y) and a row (x),
    (0,0) is the origin. If x and y are are negative values or a greater
    value than the width or height of the image, they take the value of
    edge'''
    pixel_list = image["pixels"] #make a list of the pixels in the image
    w = image['width']    
    #the following if statements will handle the special cases for the kernel
    if x < 0:
        x = 0
    if x >= image["height"]:
        x = image["height"] - 1
    if y < 0:
        y = 0
    if y >= image["width"]:
        y = image["width"] - 1
    return pixel_list[w*x+y] #call a specific pixel based on the pixel_number function


def set_pixel(image, x, y, c):
    pixel_list = image['pixels']
    width = image["width"]
    pixel_number = width*x+y
    pixel_list[pixel_number] = c
    new_image = {"height": image["height"], "width": image["width"], "pixels": pixel_list}
    #modified the original list and changed the value in image dictionary
    return new_image


def apply_per_pixel(image, func):
    result = {
        'height': image.get('height'),
        'width': image.get("width"),
    }
    pixel_list = []
    result['pixels'] = pixel_list #add the empty list in the dictionary
    for x in range(image['height']):
        for y in range(image['width']):
            color = get_pixel(image, x, y)
            newcolor = func(color)
            pixel_list.append(newcolor) #append in order to the list
    result["pixels"] = pixel_list #modify the value of pixel_list in the dictionary
    return result

def inverted(image):
    return apply_per_pixel(image, lambda c: 255-c) #changed 256 to 255

# HELPER FUNCTIONS

def find_side_length(kernel):
    ''' helper function to find side length of a kernel that is given as a list of pixels'''
    if len(kernel) == 1:
        return 1
    for int in range (len(kernel)):
        if int**2 == len(kernel):
            return int


def pixels_for_kernel(image, kernel, x, y):
    ''' gives a section of the image (kernel sized) centered at position column y and row x
    if it is an edge, gives colors of the corners'''
    pixel_square = []
    side_length = find_side_length(kernel)
    n = side_length//2
    for x_value in range (side_length):
        for y_value in range (side_length):
            new_pixel = get_pixel(image, x-n+x_value, y-n+y_value)
            pixel_square.append(new_pixel)
    return pixel_square


def multiplying_lists(l1, l2):
    '''given 2 lists of the same size, it multiplies each value of each list,
    by the value on the other list with the same index. It gives the sum of
    all of the multiplications'''
    answer = 0
    for num in range (len(l1)):
        mult = l1[num]*l2[num]
        answer += mult
    return answer
        
    
def correlate(image, kernel):
    """
    Compute the result of correlating the given image with the given kernel.

    The output of this function should have the same form as a 6.009 image (a
    dictionary with 'height', 'width', and 'pixels' keys), but its pixel values
    do not necessarily need to be in the range [0,255], nor do they need to be
    integers (they should not be clipped or rounded at all).

    This process should not mutate the input image; rather, it should create a
    separate structure to represent the output.

    The kernel is represented in a list of pixels, starting with the first row (left to right)
    and then the second row and so on.
    """
    new_image = []
    #new_image is a list that will be the pixels of my edited image
    for x_value in range (image["height"]):
        for y_value in range (image["width"]):
        #the two for loops will run into all the pixels of the original photo and
        #edit them according to the multiplication function
            image_list = pixels_for_kernel(image, kernel, x_value, y_value)
            new_pixel= multiplying_lists(kernel, image_list)
            new_image.append(new_pixel)
    final_image = { "width": image["width"], "height": image["height"], "pixels": new_image}
    return final_image
    


def round_and_clip_image(image):
    """
    Given a dictionary, ensure that the values in the 'pixels' list are all
    integers in the range [0, 255].

    All values should be converted to integers using Python's `round` function.

    Any locations with values higher than 255 in the input should have value
    255 in the output; and any locations with values lower than 0 in the input
    should have value 0 in the output.
    """
    pixel_list = image["pixels"]
    new_pixel_list = []
    for pix in pixel_list:
        if pix < 0:
            new_pixel_list.append(0)
        elif pix > 255:
            new_pixel_list.append(255)
        else:
            new_pixel_list.append(round(pix))
    new_image = {"width": image["width"], "height": image["height"], "pixels": new_pixel_list}       
    return new_image

# FILTERS

def blur_kernel(n):
    ''' returns a list that represents a square kernel of side length n, such that all
    of the values are equal and add up to  1.'''
    size = n**2
    value_per_pixel = 1/size #values will add up to 1
    kernel = []
    for pixel in range(size):
        kernel.append(value_per_pixel)
    return kernel

def blurred(image, n):
    """
    Return a new image representing the result of applying a box blur (with
    kernel size n) to the given input image.

    This process should not mutate the input image; rather, it should create a
    separate structure to represent the output.
    """
    kernel = blur_kernel(n)
    unrounded_image = correlate(image, kernel)
    new_image = round_and_clip_image(unrounded_image)    
    return new_image

def sharpened(image, n):
    ''' returns an image with the specifications of 5.2 of the assignment
    i is the original pixels and b are the blurred pixels
    '''
    i = image["pixels"]
    kernel = blur_kernel(n)
    b_dict = correlate(image, kernel)
    #didn't use the blblurred method because it used round and clip, which I want to use at the end only
    b = b_dict["pixels"]
    s = []
    for pixel in range (len(i)):
        s_value = 2*i[pixel] - b[pixel]
        s.append(s_value)
    unrounded_image = {"height": image["height"], "width": image["width"], "pixels": s}
    new_image = round_and_clip_image(unrounded_image)    
    return new_image

def edges(image):
    ''' returns an image with the especifications of part 6 of the assignment 
    uses two kernels, k_x and k_y, specified below.'''
    k_x = [-1,0,1,-2,0,2,-1,0,1]
    k_y = [-1,-2,-1,0,0,0,1,2,1]
    o_x_dict = correlate(image, k_x)
    o_x = o_x_dict["pixels"]
    o_y_dict = correlate(image,k_y)
    o_y = o_y_dict["pixels"]
    new_pixel_list = []
    for pixel in range (len(o_x)):
        new_value = (o_x[pixel]**2 + o_y[pixel]**2)**0.5
        #operation done with two kernels
        new_pixel_list.append(new_value)
    unrounded_image = {"height": image["height"], "width": image["width"], "pixels": new_pixel_list}
    new_image = round_and_clip_image(unrounded_image)    
    return new_image

# VARIOUS FILTERS


def color_filter_from_greyscale_filter(filt):
    """
    Given a filter that takes a greyscale image as input and produces a
    greyscale image as output, returns a function that takes a color image as
    input and produces the filtered color image.
    """
    def color_function (image):
        ''' Input is a 6.009 colour image, with height, width and pixel in a list,
        each made of a tuple of the value of red, green and blue they have, a value
        between 0 and 255
        
        It returns an image that modifies the initial image with a filter, filt,
        acting individually on each colour of the pixels.'''

        pixel_list = image["pixels"]
        red_image = []
        green_image = []
        blue_image = []
        for pixel in range (len(pixel_list)):
            the_pixel = pixel_list[pixel]
            red_image.append(the_pixel[0])
            green_image.append(the_pixel[1])
            blue_image.append(the_pixel[2])
            # Now I have three lists, each with the red, green and blue values, respectively, for each pixel
        red_image_dict = {"height": image["height"], "width": image["width"], "pixels": red_image}
        green_image_dict = {"height": image["height"], "width": image["width"], "pixels": green_image}
        blue_image_dict = {"height": image["height"], "width": image["width"], "pixels": blue_image}
        new_red_dict = filt(red_image_dict)
        new_red = new_red_dict["pixels"]
        new_green_dict = filt(green_image_dict)
        new_green = new_green_dict["pixels"]
        new_blue_dict = filt(blue_image_dict)
        new_blue = new_blue_dict["pixels"]
        # The new images correspond to the altered values, they are a dictionary with the same width and height
        # of the original image, but the pixel values of each list (for each colour) are altered by the filter.
        new_image_list = []
        for pixel in range (len(new_red)):
            new_pixel = (new_red[pixel], new_green[pixel], new_blue[pixel])
            # Appends each new tuple to the list fot the final image
            new_image_list.append(new_pixel)
        new_image = {"height": image["height"], "width": image["width"], "pixels": new_image_list}
        return new_image
    return color_function


def make_blur_filter(n):
    ''' This filter inputs a value n, which is the sidelength of the kernel used to blur the image
    and outputs a function to blur an image with only one input, the original image.
    '''
    def new_blur_filter(image):
        return blurred(image, n)
    return new_blur_filter


def make_sharpen_filter(n):
    ''' This filter inputs a value n, which is the sidelength of the kernel used to sharpen the image
    and outputs a function to blur an image with only one input, the original image.
    '''
    def new_sharpen_filter(image):
        return sharpened(image,n)
    return new_sharpen_filter


def filter_cascade(filters):
    """
    Given a list of filters (implemented as functions on images), returns a new
    single filter such that applying that filter to an image produces the same
    output as applying each of the individual ones in turn.
    """
    def big_filter(image):
        ''' given an image, this function will return a filter that combines all of the
        filters of the filter_cascade input.'''
        new_image = image
        for fil in range (len(filters)):
            current_filter = filters[fil]
            temp = current_filter(new_image)
            #I made a temp so that I don't iterate in the unrounded_image in an undecired way
            new_image = temp
        return new_image
    return big_filter




# SEAM CARVING

# Main Seam Carving Implementation


# Optional Helper Functions for Seam Carving

def greyscale_image_from_color_image(image):
    """
    Given a color image, computes and returns a corresponding greyscale image.

    Returns a greyscale image (represented as a dictionary).
    """
    pixel_list = image["pixels"]
    greyscale_pixel_list = []
    for pix in range (len(pixel_list)):
        pixel_tuple = pixel_list[pix]
        # This are the values for red, green and blue for each pixel
        r = pixel_tuple[0]
        g = pixel_tuple[1]
        b = pixel_tuple[2]
        v = round(0.299*r + 0.587*g + 0.114*b)
        greyscale_pixel_list.append(v)
        # In my new pixel list, I am appending the greyscale value of each pixel, according to the formula given
    new_image = {"height": image["height"], "width": image["width"], "pixels": greyscale_pixel_list}
    return new_image


def compute_energy(grey):
    """
    Given a greyscale image, computes a measure of "energy", in our case using
    the edges function from last week.

    Returns a greyscale image (represented as a dictionary).
    """
    new_image = round_and_clip_image(edges(grey))
    return new_image


def cumulative_energy_map(energy):
    """
    Given a measure of energy (e.g., the output of the compute_energy function),
    computes a "cumulative energy map" as described in the lab 1 writeup.

    Returns a dictionary with 'height', 'width', and 'pixels' keys (but where
    the values in the 'pixels' array may not necessarily be in the range [0,
    255].
    """
    cumulative_energy = energy
    for x in range (1, cumulative_energy["height"]):
        for y in range(cumulative_energy["width"]):
            pixel_energy = get_pixel(energy, x, y)
            opt1 = get_pixel(cumulative_energy, x-1, y-1)
            opt2 = get_pixel(cumulative_energy, x-1, y)
            opt3 = get_pixel(cumulative_energy, x-1, y+1)
            chosen = min(opt1, opt2, opt3)
            new_pix = chosen + pixel_energy
            temp = set_pixel(cumulative_energy, x, y, new_pix)
            cumulative_energy = temp
    return cumulative_energy    
          

def minimum_energy_seam(c):
    """
    Given a cumulative energy map, returns a list of the indices into the
    'pixels' list that correspond to pixels contained in the minimum-energy
    seam (computed as described in the lab 1 writeup).
    """
    h = c["height"]
    w = c["width"]
    seam = []
    # Since the whole process begins identifying the lower cumulative energy of the
    # bottom row, I will first do an iteration to identify the pixel from the bottom
    # row I should remove
    last_row = {}
    for y in range (w):
        pix = get_pixel(c,h,y)
        last_row[y] = pix
    rem_val = min(last_row.values())
    for y in range (w):
        if last_row[y] == rem_val:
            rem_ind = y+(h-1)*w
            # The question is adding for index number, not pixel value, so I need to find this
            start = y
            break
            # I break so that it takes the left-most value as specified in the instructions of the lab
    seam.append(rem_ind)
    # Now I must create the path from this bottom pixel
    for x in range (h-1, 0, -1):
        opt1 = get_pixel(c, x-1, start-1)            
        opt2 = get_pixel(c, x-1, start)
        opt3 = get_pixel(c, x-1, start+1)
        next = min(opt1, opt2, opt3)
        if next == opt1 and start > 0:
        # The inequality is necessary to avoid start = -1 after the if statement,
        # which would result in a misscount
            temp = start-1
            start = temp
            seam.append(start+w*(x-1))
        elif next == opt2:
            seam.append(start+w*(x-1))
        elif next == opt3:
            temp = start+1
            start = temp
            seam.append(start+w*(x-1))
    return seam


def image_without_seam(im, s):
    """
    Given a (color) image and a list of indices to be removed from the image,
    return a new image (without modifying the original) that contains all the
    pixels from the original image except those corresponding to the locations
    in the given list.
    """
    pixel_list = im["pixels"]
    pixel_list2 = pixel_list.copy()
    for element in s:
        del pixel_list2[element]
    new_image = {"height": im["height"], "width": im["width"]-1, "pixels": pixel_list2}
    return new_image

def seam_carving(image, ncols):
    """
    Starting from the given image, use the seam carving technique to remove
    ncols (an integer) columns from the image.
    Returns the new carved image
    """
    im = image
    for time in range (ncols):
        grey = greyscale_image_from_color_image(im)
        energy = compute_energy(grey)    
        map = cumulative_energy_map(energy)
        seam = minimum_energy_seam(map)
        temp = image_without_seam(im, seam)
        im = temp
    return im


# HELPER FUNCTIONS FOR LOADING AND SAVING COLOR IMAGES

def color_switch(im,p,q):
    ''' Given an image, it returns an image and two letters p,q which have to be either r, g or b
    it returns an image with the rgb values of those two letters switched.
    '''
    pixel_list = im["pixels"]
    pixel_copy = []
    if p == "r" or q == "r":
        if p == "g" or q == "g":
            v0 = 1
            v1 = 0
            v2 = 2
        if p == "b" or q == "b":
            v0 = 2
            v2 = 0
    else:
        v0 = 0
        v1 = 2
        v2 = 1
    for pix in pixel_list:
        pixel_copy.append((pix[v1], pix[v2], pix[v0]))
    new_image = {"height": im["height"], "width": im["width"], "pixels": pixel_copy}
    return new_image


def load_color_image(filename):
    """
    Loads a color image from the given file and returns a dictionary
    representing that image.

    Invoked as, for example:
       i = load_image('test_images/cat.png')
    """
    with open(filename, 'rb') as img_handle:
        img = Image.open(img_handle)
        img = img.convert('RGB')  # in case we were given a greyscale image
        img_data = img.getdata()
        pixels = list(img_data)
        w, h = img.size
        return {'height': h, 'width': w, 'pixels': pixels}


def save_color_image(image, filename, mode='PNG'):
    """
    Saves the given color image to disk or to a file-like object.  If filename
    is given as a string, the file type will be inferred from the given name.
    If filename is given as a file-like object, the file type will be
    determined by the 'mode' parameter.
    """
    out = Image.new(mode='RGB', size=(image['width'], image['height']))
    out.putdata(image['pixels'])
    if isinstance(filename, str):
        out.save(filename)
    else:
        out.save(filename, mode)
    out.close()


if __name__ == '__main__':
    # code in this block will only be run when you explicitly run your script,
    # and not when the tests are being run.  this is a good place for
    # generating images, etc.

    
    image = load_color_image("lab1/lab1/test_images/frog.png")
    im = color_switch(image,"r","g")


    save_color_image(im, "lab1/lab1/test_images/b3luefrog.png")