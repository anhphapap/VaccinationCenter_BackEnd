from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec
import csv

def cate_info():
    driver = webdriver.Edge()

    driver.get('https://vnvc.vn/thong-tin-san-pham-vac-xin/')

    urls = []
    data = []
    ele = WebDriverWait(driver,10).until(ec.presence_of_all_elements_located((By.CSS_SELECTOR,'#owl-child-cate > div > div > div > div.owl-wrapper-outer.autoHeight > div > div')))
    for e in ele:
        url = e.find_element(By.CSS_SELECTOR, "div.item > div:nth-child(1) > a").get_attribute("href")
        urls.append(url)
    for i,u in enumerate(urls):
        driver.get(u)
        while True:
            try:
                btnNext = driver.find_element(By.CSS_SELECTOR,'ul.pagination > li:last-child')
            except:
                btnNext = None
            try:
                ele = WebDriverWait(driver,10).until(ec.presence_of_all_elements_located((By.CLASS_NAME,'title_item_vacxin')))
            except:
                ele = []
            for e in ele:
                data.append({
                    "vac_id" : e.get_attribute('href').strip('/').split('/')[-1],
                    "cate_id" : i+1
                })
            if btnNext == None or btnNext.get_attribute('class') != 'item_k':
                break
            else:
                btnNext.find_element(By.CSS_SELECTOR, "a").click()

    with open("vac_cate.csv", mode="w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)
    driver.quit()

cate_info()