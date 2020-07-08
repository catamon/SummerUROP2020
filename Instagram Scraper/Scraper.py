

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





def posts_by_tag():
    ''' Given a tag and a number of posts, this function returns a dictionary with the info of
    the top posts of that tag in instagram
    '''
    manual_location = input("Enter the name of the location manually: ") #change to auto-retrieve

    # Creating a CSV file with the information of every post
    filename = "Collected_Data/" + manual_location + ".csv"
    f = open(filename, "w")
    headers = "Location, Date, Image number, Account, URL\n"
    f.write(headers)
    # this will create a csv for each location, If I want it to do it all in the same file I can't create the file in my code (maybe except)
    # because it will re-write each time


    url, max_date = run()
    min_date = input('Enter the min date in this form: 1999-7-27...')
    print("Getting images from: ",url)
    browser = webdriver.Chrome(r"C:\Webdrivers\chromedriver.exe")
    browser.get(url)
    # Now I should be on the website with the posts from the input date as a max date

    post = 'https://www.instagram.com/p/'
    post_links = set() #probar cambiar a set para optimizar, despues de que funcione con list para debug
    not_date = set()
    i = 0
    while True:
        # h-ref extraction from Corgis method
        links = [a.get_attribute('href')
                 for a in browser.find_elements_by_tag_name('a')]

        for link in links:
            if post in link and link not in post_links and link not in not_date:
                i+=1
                post_data = find_data(link, min_date, max_date, manual_location, i)
                if post_data == None: # Will go into this statement if the date of the post is out of range
                    not_date.add(link)
                    if i > 9: # if it goes through this it means that one of the non "top posts" is out of date
                        browser.close()
                        print("Posts in date range retrieved")
                        return
                elif post_data == "after":
                    not_date.add(link)
                else:
                    f.write(post_data)
                    post_links.add(link)
        scroll_down = "window.scrollTo(0, document.body.scrollHeight);"
        browser.execute_script(scroll_down)
        time.sleep(5)
        #sleeptime is to give time to the page to load
    browser.close()
    return len(not_date), len(post_links)

def get_ld_json(url: str) -> dict:
    ''' This method I took from StackOverFlow as an alterantive method to get the json-ld of a post'''
    # parser = "html.parser"
    # req = requests.get(url)
    # page_soup = soup(req.text, parser)
    # return json.loads("".join(page_soup.find("script", {"type":"application/ld+json"})))
    html = requests.get(url)
    p_soup = soup(html.text, 'lxml')
    item = p_soup.select_one("meta[property='og:description']")
    name = item.find_previous_sibling().get("content").split("•")[0]
    print(name)

def find_data(post, min_date_unsplit, max_date_unsplit, location, i=0):

    # post_info = get_ld_json(post)
    # print(post_info)
    r = requests.get(post)
    html = r.text
    page_soup = soup(html, "html.parser")
    image_dict = page_soup.select('script[type="application/ld+json"]')
    if image_dict == []: #attempt to find the application/json-ld problem
        #Insert code for what to do when no date on post
        #must create variables called location and account, date_unsplit
        date_unsplit = "No date"
        account = "unknown"
        date_unsplit = "unknown"


    else: #if the json-ld exists
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
            if date(min_date[0], min_date[1], min_date[2]) > date(post_date[0], post_date[1], post_date[2]): #earlier than the date
                return None #end the loop if its not in the "top posts" section
            else:
                return "after" #events happen after the specified range
        #passes this means it is on the date range and we can work with it  

        account = post_info["author"]["alternateName"]

    # Downloading the image
    folder ="Collected_Data/" + location + "/" + date_unsplit + "/"
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
    
    new_line = location + "," + date_unsplit + "," + str(i) + "," + account + "," + post + "\n"
    return new_line

posts_by_tag()


'''
COMENTARIOS GENERALES

- The method for link that retrieves posts from a location/date sometimes doesn't work well and gives me dates from posts after the
specified range, I worked around this but still may not be optional if location has lots of posts related to it and the date is
behind.

- Fetching some data it seams that past instagram posts monstly have the json-ld that gives me all the account/date information.
This is not constant tho, some really new posts still have the json-ld.

- When I input a MAX date which is before a certain date (still haven't figure out which), opening the link retrieved from the
date location method gives me an instagram page saying there is an error. I have to figure out if this is because of the date, or 
because the location does not ahve enough posts before this date.

- When a post does not have json-ld, the code still downloads it and puts its information in the csv file, even if it is not in the
date range. This may be an issue if the location/date method is showing a lot of posts from previous dates.

- The posts_by_tag method assumes that if it encounters a post with a date before the MIN date and not in the first 9 posts (which
are supposed to be the "top posts" section) then it returns and assumes all possible posts are being retrieved. This works well if
the location/date function page is in chronological order, which it should be. But since the location/date function has been working
wierd, then I need to find a way to check this is true.
'''

#print(find_data("https://www.instagram.com/p/B87PsPRDekN/", "2020-6-1", "2020-6-30"))
#get_ld_json("https://www.instagram.com/p/BkdqGqihzIv/")


