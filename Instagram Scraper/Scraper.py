

# IMPORTS
from bs4 import BeautifulSoup as soup
from urllib.request import urlopen
from selenium import webdriver
#browser = webdriver.Chrome(r"C:\Webdrivers\chromedriver.exe")
import time
import requests
ig_url = "https://www.instagram.com/"


def posts_by_tag(tag, num_posts, page_type = "hashtag"):
    ''' Given a tag and a number of posts, this function returns a dictionary with the info of
    the top posts of that tag in instagram
    '''
    
    if page_type == "user":
        url = ig_url + tag
        print("Getting the top "+ str(num_posts) + "posts of @" + tag + " account")
    else:
        url = ig_url + "tags/" + tag
        print("Getting the top "+ str(num_posts) + "posts of #" + tag + " hashtag")

    browser.get(url)

    # code copied and modified from corgies method

    post = 'https://www.instagram.com/p/'
    post_links = []
    while len(post_links) < num_posts:
        print( str(len(post_links)) + " out of " + str(num_posts) + " posts retrieved...")
        # h ref id an attribute of the tag, we will be working on this so we extract it
        links = [a.get_attribute('href')
                 for a in browser.find_elements_by_tag_name('a')]
        for link in links:
            if post in link and link not in post_links:
                # this if statement is used because the links above has all the links in the page,
                # but we only need the post links, found with our defined posts url.
                # post_links is where we are already storing the links and we dont want to add a link
                # twice so we only store if its not in the list already.
                post_links.append(link)
        scroll_down = "window.scrollTo(0, document.body.scrollHeight);"
        browser.execute_script(scroll_down)
        time.sleep(2) #CHANGE TO MOREEEEE
        #sleeptime is to give time to the page to load
    print("Link retrieving completed!")
    browser.close()
    return post_links[:num_posts]

def image_data(urls, location = ""):
    i = 0
    n_posts = len(urls)
    for post in urls:
        print(str(i) + " out of "  + str(n_posts) + " images downloaded")
        r = requests.get(post)
        html = r.text
        page_soup = soup(html, "html.parser")

        # Downloading the image
        photo_url = page_soup.find("meta", property="og:image")['content']
        name = location + str(i) + ".png"
        req_url = requests.get(photo_url)
        with open(name, 'ab') as f:
            f.write(req_url.content)

        # Adding info to CSV file
        image_dict = page_soup.select('script[type="application/ld+json"]')


urls = ["https://www.instagram.com/p/CAS9VTQFnkA/"]
data = image_data(urls)


# my_url = "https://www.newegg.com/Video-Cards-Video-Devices/Category/ID-38#"
# uClient = urlopen(my_url)
# page_client = uClient.read()
# uClient.close()
# page_soup = soup(page_client, "html.parser")
# posts = page_soup.findAll("div", {"class": "v1Nh3 kIKUG  _bz0w"})
# print(page_soup.p)


