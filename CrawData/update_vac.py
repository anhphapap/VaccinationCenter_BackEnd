import pandas as pd
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec
import csv
import time

df = pd.read_csv('vaccines.csv')
df['ten'] = df['ten'].str.replace(r'\s*\(.*?\)', '', regex=True)

def cate_info():
    driver = webdriver.Edge()

    driver.get('https://vax.vnvc.vn/vaccine')

    country = []
    phong_benh = []
    price = []

    search = WebDriverWait(driver, 10).until(ec.presence_of_element_located((By.CSS_SELECTOR, 'input[type="search"]')))

    for x in df['ten']:
        driver.execute_script("arguments[0].scrollIntoView(true);", search)
        time.sleep(1)

        # Dùng JavaScript gán giá trị trực tiếp (bypass send_keys)
        driver.execute_script(f"arguments[0].value = '{x}'; arguments[0].dispatchEvent(new Event('input'));", search)

        # Đợi load kết quả
        time.sleep(3)
        try:
            e = driver.find_element(By.CSS_SELECTOR, 'tbody > tr > th:nth-child(1) > div')
            c = e.find_element(By.CSS_SELECTOR, "div.d-flex.h6.my-1.text-dark.text-2-line-prevention > div:nth-child(1)").text.split(':', 1)[1].strip()
            pb = e.find_element(By.CSS_SELECTOR, "div.d-flex.h6.my-1.text-dark.text-2-line-prevention > div:nth-child(2)").text
            p = e.find_element(By.CSS_SELECTOR, "div.vaccine-information-price.h5.text-primary.font-weight-bold.pt-1 > span").text.replace(',', '').replace('VNĐ', '').strip()
            country.append(c)
            phong_benh.append(pb)
            price.append(p)
        except:
            country.append("")
            phong_benh.append("")
            price.append("")

    df['quoc_gia'] = country
    df['phong_benh'] = phong_benh
    df['gia'] = price

    df.to_csv('vaccine_new.csv', index=False)
    driver.quit()

cate_info()
