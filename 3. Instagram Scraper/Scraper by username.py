# IMPORTS
from bs4 import BeautifulSoup as soup
from urllib.request import urlopen
from selenium import webdriver
import time
import requests
import os
import json
from datetime import date

#chequear cuales de estas no sirven
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait

def login_to_instagram(browser):
    options = webdriver.ChromeOptions()
    browser.get('https://www.instagram.com/accounts/login/?source=auth_switcher')
    usernameField = WebDriverWait(browser, 10).until(EC.element_to_be_clickable((By.NAME, "username")))
    passwordField = WebDriverWait(browser, 10).until(EC.element_to_be_clickable((By.NAME, "password")))
    usernameField.send_keys("cm_urop_user")
    passwordField.send_keys("InstagramScraper")
    browser.find_element_by_xpath("/html/body/div[1]/section/main/div/article/div/div[1]/div/form/div[4]/button").click()
    time.sleep(2)
    browser.find_element_by_xpath("/html/body/div[1]/section/main/div/div/div/section/div/button").click()
    time.sleep(2)
    browser.find_element_by_xpath("/html/body/div[4]/div/div/div/div[3]/button[2]").click()

def posts_by_user(user):
    ''' Given a tag and a number of posts, this function returns a dictionary with the info of
    the top posts of that tag in instagram
    '''

    # Creating a CSV file with the information of every post
    filename = "Collected Data by Username/" + user + ".csv"
    f = open(filename, "w")
    headers = "Date, Image number, Account, URL\n"
    f.write(headers)
    # this will create a csv for each location, If I want it to do it all in the same file I can't create the file in my code (maybe except)
    # because it will re-write each time


    browser = webdriver.Chrome(executable_path=r"C:/Webdrivers/chromedriver.exe")
    login_to_instagram(browser)
    url = "http://www.instagram.com/"+user
    print("Getting images from: ",url)
    #browser = webdriver.Chrome(r"C:\Webdrivers\chromedriver.exe")
    browser.get(url)
    # Now I should be on the website with the posts from the input date as a max date

    post = 'https://www.instagram.com/p/'
    post_links = set() #probar cambiar a set para optimizar, despues de que funcione con list para debug
    i = 0
    while True:
        # h-ref extraction from Corgis method
        before_links = len(post_links)
        links = [a.get_attribute('href')
                 for a in browser.find_elements_by_tag_name('a')]

        for link in links:
            if post in link and link not in post_links:
                i+=1
                post_data = find_data(link, user, i)
                f.write(post_data)
                post_links.add(link)
        if before_links == len(post_links):
            print("Posts retrieved")
            return
        scroll_down = "window.scrollTo(0, document.body.scrollHeight);"
        browser.execute_script(scroll_down)
        time.sleep(5)
        #sleeptime is to give time to the page to load
    browser.close()
    return len(not_date), len(post_links)


def find_data(post, user, i=0):

    # post_info = get_ld_json(post)
    # print(post_info)
    r = requests.get(post)
    html = r.text
    page_soup = soup(html, "html.parser")
    image_dict = page_soup.select('script[type="application/ld+json"]')
    if image_dict == []: #attempt to find the application/json-ld problem
        #Insert code for what to do when no date on post
        #must create variables called location and account, date_unsplit
        account = user
        date_unsplit = "unknown"



    else: #if the json-ld exists
        #Check date: first step to return None if out of range
        content_text = image_dict[0].text
        content_text = content_text[17:]
        post_info = json.loads(content_text)
        date_unsplit = post_info["uploadDate"][:10]
        account = user

    # Downloading the image
    folder ="Collected Data by Username/" + user + "/"
    try:
        os.makedirs(folder) #only if the folder hasn't been created
    except:
        pass #if the folder already exist we don't need to create it again
    photo_url = page_soup.find("meta", property="og:image")['content']
    name = folder + str(i) + ".png"
    req_url = requests.get(photo_url)
    with open(name, 'ab') as p:
        p.write(req_url.content)

    # Adding info to CSV file
    
    new_line = date_unsplit + "," + str(i) + "," + account + "," + post + "\n"
    return new_line

username = input("Instagram Username: ")
posts_by_user(username)