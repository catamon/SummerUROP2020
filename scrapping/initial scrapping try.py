# this initial try is based on the corgis scrapping method found on my doc


# Imports
import time
import requests
import pandas as pd
from selenium import webdriver
from bs4 import BeautifulSoup as bs
browser = webdriver.Chrome(r"C:\Webdrivers\chromedriver.exe")

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

def get_ss(links, location=""):
    ''' Given a list of links, this function screenshots the content of opening those
    links in the browser and saves them in a specified location
    '''
    for i in range (len(links)):
        browser.get(links[i])
        browser.save_screenshot(location + "img-" + str(i) + ".png")
        time.sleep(2)

def img_download(post_links, location = ""):
    i = 0
    n_posts = len(post_links)
    for post in post_links:
        print(str(i) + " out of "  + str(n_posts) + " images downloaded")
        r = requests.get(post)
        html = r.text
        soup = bs(html, "lxml")
        photo_url = soup.find("meta", property="og:image")['content']

        name = location + str(i) + ".png"
        req_url = requests.get(photo_url)
        with open(name, 'ab') as f:
            f.write(req_url.content)
        i += 1
    print("Download completed!")

      

urls = posts_by_tag("artesano_inc",10, "user")
img_download(urls, "username/artesano_inc/")