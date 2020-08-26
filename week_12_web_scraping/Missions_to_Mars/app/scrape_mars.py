from splinter import Browser
from bs4 import BeautifulSoup
import re
import time
import pandas as pd
import datetime as dt



def scrape_all():

    browser = Browser("chrome", executable_path="chromedriver", headless=True)
    news_title, news_paragraph = mars_news(browser)

    data = {
        "news_title": news_title,
        "news_paragraph": news_paragraph,
        "featured_image": featured_image(browser),
        "hemispheres": hemispheres(browser),
        "weather": twitter_weather(browser),
        "facts": mars_facts(),
        "last_modified": dt.datetime.now()
    }

    # Stop webdriver and return data
    browser.quit()
    return data

# ## Scrape the NASA Mars News Site and collect the latest News Title and Paragraph Text. Assign the text to variables that you can reference later.

def mars_news(browser):
    browser.visit('https://mars.nasa.gov/news/')
    browser.is_element_present_by_css("ul.item_list li.slide", wait_time=1)

    bsoup = BeautifulSoup(browser.html, 'html.parser')

    try:
        slide_elem = bsoup.select_one('ul.item_list li.slide')
        #slide_elem.find("div", class_='content_title')
        news_title = slide_elem.find("div", class_='content_title').get_text()

        article_teaser = slide_elem.find('div', class_="article_teaser_body").get_text()
        #print(f'"news_title" div contains : [{news_title}]')
        #print(f'"article_teaser_body" div contains : [{article_teaser}]')

    except AttributeError:
        return None, None

    return news_title, article_teaser


# ## JPL Mars Space Images - Featured Image
def featured_image(browser):
    
    browser.visit('https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars')
    image_elem = browser.find_by_id('full_image')
    image_elem.click()

    browser.is_element_present_by_text('more info', wait_time=1)
    more_info_elem = browser.find_link_by_partial_text('more info')
    more_info_elem.click()
    
    img_pull = BeautifulSoup(browser.html, 'html.parser')

    try:
        img_url_rel = img_pull.select_one('figure.lede a img').get("src")

    except AttributeError:
        return None

    featured_image_url = f'https://www.jpl.nasa.gov{img_url_rel}'
    #print(f'featured_image_url : {featured_image_url}')
    return featured_image_url

# ## Visit the Mars Weather twitter account here and scrape the latest Mars weather tweet from the page. Save the tweet text for the weather report as a variable called mars_weather

def twitter_weather(browser):
    browser.visit('https://twitter.com/marswxreport?lang=en')
    time.sleep(4)

    html = browser.html
    weather_soup = BeautifulSoup(html, 'html.parser')
    mars_weather_tweet = weather_soup.find('div', attrs={"class": "tweet", "data-name": "Mars Weather"})
    try:
        mars_weather = mars_weather_tweet.find("p", "tweet-text").get_text()

    except AttributeError:

        pattern = re.compile(r'sol')
        mars_weather = weather_soup.find('span', text=pattern).text
    
    #print(f'mars_weather : [{mars_weather}]')
    return mars_weather

# ## Visit the USGS Astrogeology site here to obtain high resolution images for each of Mar's hemispheres.

def hemispheres(browser):

    browser.visit('https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars')

    hemisphere_images = []

    all_prods_list = browser.find_by_css("a.product-item h3")
    for i in range(len(all_prods_list)):
        mars_hemi_dict = {}
        browser.find_by_css("a.product-item h3")[i].click()

        sample_elem = browser.find_link_by_text('Sample').first
        mars_hemi_dict['img_url'] = sample_elem['href']
        mars_hemi_dict['title'] = browser.find_by_css("h2.title").text
        hemisphere_images.append(mars_hemi_dict)    
        browser.back()
    #print(f'hemisphere_images : {"--"*20}\n\n {hemisphere_images}')
    return hemisphere_images

# ## Space Facts : Mars
def mars_facts():
    try:
        space_facts_df = pd.read_html('https://space-facts.com/mars/')[0]
    except BaseException:
        return None
    
    space_facts_df.columns=['description', 'value']
    space_facts_df.set_index('description', inplace=True)

    return  space_facts_df.to_html(classes="table table-striped")
    

if __name__ == "__main__":

    print(scrape_all())
