from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec
import csv

def cate_info():
    driver = webdriver.Edge()

    driver.get('https://vnvc.vn/thong-tin-san-pham-vac-xin/')

    data = []
    ele = WebDriverWait(driver,10).until(ec.presence_of_all_elements_located((By.CSS_SELECTOR,'#owl-child-cate > div > div > div > div.owl-wrapper-outer.autoHeight > div > div')))
    for e in ele:
        img = e.find_element(By.CLASS_NAME, "img-responsive").get_attribute("src")
        name =e.find_element(By.CSS_SELECTOR, 'a.title_cate_child.sz_15.cl_white').text
        data.append({
            "image" : img,
            "ten": name
        })
    print(data, len(data))
    with open("categories.csv", mode="w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)
    driver.quit()

cate_info()