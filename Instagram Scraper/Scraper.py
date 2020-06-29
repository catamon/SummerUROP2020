

# IMPORTS
from bs4 import BeautifulSoup as soup
from urllib.request import urlopen
from selenium import webdriver
import time
import requests
import os
import json
from datetime import date

# Using this code from https://repl.it/repls/FormalYellowgreenLinux#main.py we can get the link for
# the posts of a place on a specific date and before that. After that we can use the Scraper.py file
# to get the data of the posts


import datetime

def get_location()->str:
    return input('Enter the URL of the location (for example: https://www.instagram.com/explore/locations/95099702/mgm-grand-las-vegas/)')
def get_date()-> str:
    return input('Enter the MAX date in this form: 1999-7-27...')
def date_str_2_dateobj(date: str) -> datetime.datetime:
    d_list = date.split("-")
    return datetime.datetime(int(d_list[0]), int(d_list[1]), int(d_list[2]), 23, 59, 59)

def date_2_unix(date_obj: datetime.date)-> int:
    unixdate = date_obj - datetime.datetime(1970,1,1)
    mstime = int(unixdate.total_seconds() * 1000.0)
    insta_epoch = mstime - 1314220021300
    return insta_epoch

def binary_decimal_convert(bindec: tuple)-> int:
    if bindec[0]:
        return int(bin(bindec[1])[2:])
    else:
        return int(bindec[1], 2)

def binary_lengthen(binary: int)-> int:
    zeroes = 41 - len(str(binary))
    six_fourbit = ('0' * zeroes) + str(binary) + ('0' * 23)
    return six_fourbit

def run():
    location_url = get_location()
    max_date = get_date()
    unix_time = date_2_unix(date_str_2_dateobj(max_date))
    newbin = binary_decimal_convert((True, unix_time))
    longbin = binary_lengthen(newbin)
    final_num = binary_decimal_convert((False, longbin))
    return location_url + '?max_id=' + str(final_num), max_date


# Creating an Excel with the information of every post
filename = "Collected Data.csv"
f = open(filename, "w")
headers = "Location, Date, Image number, Account, URL\n"
f.write(headers)


def posts_by_tag():
    ''' Given a tag and a number of posts, this function returns a dictionary with the info of
    the top posts of that tag in instagram
    '''
    url, max_date = run()
    min_date = input('Enter the min date in this form: 1999-7-27...')
    browser = webdriver.Chrome(r"C:\Webdrivers\chromedriver.exe")
    browser.get(url)
    # Now I should be on the website with the posts from the input date as a max date

    post = 'https://www.instagram.com/p/'
    post_links = [] #probar cambiar a set para optimizar, despues de que funcione con list para debug
    not_date = []
    i = 0
    while len(not_date) <= 9: # If it is more than 9 it means I have reached my min_date and should stop looping
        # h-ref extraction from Corgis method
        links = [a.get_attribute('href')
                 for a in browser.find_elements_by_tag_name('a')]

        for link in links:
            i += 1
            if post in link and link not in post_links and link not in not_date:
                post_data = find_data(link, min_date, max_date, i)
                if post_data == None: # Will go into this statement if the date of the post is out of range
                    not_date.append(link)
                else:
                    post_links.append(link)
        scroll_down = "window.scrollTo(0, document.body.scrollHeight);"
        browser.execute_script(scroll_down)
        time.sleep(5)
        #sleeptime is to give time to the page to load
    browser.close()
    return post_links[:num_posts]

def get_ld_json(url: str) -> dict:
    ''' This method I took from StackOverFlow as an alterantive method to get the json-ld of a post'''
    parser = "html.parser"
    req = requests.get(url)
    page_soup = soup(req.text, parser)
    return json.loads("".join(page_soup.find("script", {"type":"application/ld+json"})))

def find_data(post, min_date_unsplit, max_date_unsplit, i=0):

    # post_info = get_ld_json(post)
    # print(post_info)
    r = requests.get(post)
    html = r.text
    page_soup = soup(html, "html.parser")
    print("AQUI EMPIEZA ",page_soup)
    image_dict = page_soup.select('script[type="application/ld+json"]')

    #Check date: first step to return None if out of range
    content_text = image_dict[0].text
    content_text = content_text[17:]
    post_info = json.loads(content_text)
    date_unsplit = post_info["uploadDate"][:10]

    #determining if in date range
    post_date = date_unsplit.split("-")
    post_date = [int(i) for i in post_date]
    min_date = min_date_unsplit.split("-")
    min_date = [int(i) for i in min_date]
    max_date = max_date_unsplit.split("-")
    max_date = [int(i) for i in max_date]
    if date(min_date[0], min_date[1], min_date[2]) <= date(post_date[0], post_date[1], post_date[2]) <= date(max_date[0], max_date[1], max_date[2]):
        pass
    else:
        return None
    #passes this means it is on the date range and we can work with it  

    location_dict = post_info["contentLocation"]
    location = location_dict["name"]
    folder ="Collected_Data/" + location + "/" + date_unsplit + "/"
    try:
        os.makedirs(folder)
    except:
        pass

    # Downloading the image
    photo_url = page_soup.find("meta", property="og:image")['content']
    name = folder + str(i) + ".png"
    req_url = requests.get(photo_url)
    with open(name, 'ab') as p:
        p.write(req_url.content)

    # Adding info to CSV file
    account = post_info["author"]["alternateName"]
    new_line = location + "," + date_unsplit + "," + str(i) + "," + account + "," + post
    f.write(new_line)

#posts_by_tag()
    
print(find_data("https://www.instagram.com/p/B87PsPRDekN/", "2020-6-1", "2020-6-30"))



