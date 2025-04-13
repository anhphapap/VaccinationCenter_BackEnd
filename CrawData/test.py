from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec
import csv

def cate_info():
    driver = webdriver.Edge()

    driver.get('https://vnvc.vn/thong-tin-san-pham-vac-xin/')
    btnNext = driver.find_element(By.CSS_SELECTOR,'ul.pagination > li:last-child')
    btnNext.find_element(By.CSS_SELECTOR, "a").click()
    driver.quit()

cate_info()