# IMPORTS
import cv2 as cv;
import numpy
from matplotlib import pyplot as plt

# Basic pixel manipulation and image display using CV and numpy.

# img = cv.imread('data/original1.png')

# for i in range(len(img)): #len(img) = height
#     if i % 3 == 0:
#         for j in range (len(img[i])): #width
#             img[i,j] = (0,0,0) # "horizontal polarization" type effect. Colors in BGR


# cv.imshow("image",img)
# cv.waitKey(0) # window will only close when 0 pressed but img will still be saved
# cv.destroyAllWindows()
# cv.imwrite('basicpixels.png',img)

img = cv.imread('original.png')
plt.imshow(img)
plt.xticks([]), plt.yticks([])  # to hide tick values on X and Y axis
plt.show()