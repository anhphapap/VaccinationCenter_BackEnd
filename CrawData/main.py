from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as ec
import csv


def get_all_text(driver, xpath):
    try:
        elements = driver.find_elements(By.XPATH, xpath)
        return "\n".join([el.text.strip() for el in elements if el.text.strip()])
    except:
        return ""

def get_text(driver, text, type):
    try:
        if type == "class":
            return driver.find_element(By.CLASS_NAME, text).text
        if type == "css":
            return driver.find_element(By.CSS_SELECTOR, text).text
        if type == "xpath":
            return driver.find_element(By.XPATH, text).text
    except:
        return ""
    
def get_html(driver, text, type):
    try:
        if type == "class":
            return driver.find_element(By.CLASS_NAME, text).get_attribute('outerHTML')
        if type == "css":
            return driver.find_element(By.CSS_SELECTOR, text).get_attribute('outerHTML')
        if type == "xpath":
            return driver.find_element(By.XPATH, text).get_attribute('outerHTML')
    except:
        return ""

def vaccin_info():
    driver = webdriver.Edge()

    driver.get('https://vnvc.vn/thong-tin-san-pham-vac-xin/')

    urls = []
    for i in range(2,7):
        ele = WebDriverWait(driver,10).until(ec.presence_of_all_elements_located((By.CLASS_NAME,'title_item_vacxin')))
        img = driver.find_elements(By.CSS_SELECTOR, '.item_vacxin > a > img')
        for idx, e in enumerate(ele):
            urls.append({
                "link" : e.get_attribute('href'),
                "slug" : e.get_attribute('href').strip('/').split('/')[-1],
                "image" : img[idx].get_attribute('src')
            })
        if(i <= 5):
            driver.get(f'https://vnvc.vn/thong-tin-san-pham-vac-xin/page/{i}')
 
    data = []

    for u in urls:
        driver.get(u['link'])
        d = {
            "ten" : get_text(driver, 'title_thong_in_vacxin', 'class'),
            "mo_ta" : get_html(driver, '.content_item_list > p:nth-child(1)', 'css'),
            "nguon_goc" : get_html(driver , '//*[@id="1-thong-tin-vac-xin"]/div/h3[1]/following-sibling::*[1]', 'xpath'),
            "duong_tiem" : get_html(driver, '//*[@id="1-thong-tin-vac-xin"]/div/h3[2]/following-sibling::*[1]', 'xpath'),
            "chong_chi_dinh" : get_html(driver, '//*[@id="1-thong-tin-vac-xin"]/div/h3[3]/following-sibling::*[1]', 'xpath'),
            "hdsd" : get_html(driver, '//*[@id="1-thong-tin-vac-xin"]/div/h3[4]/following-sibling::*[1]', 'xpath'),
            "bao_quan" : get_html(driver, '//*[@id="1-thong-tin-vac-xin"]/div/h3[last()]/following-sibling::*[1]', 'xpath'),
            "doi_tuong" : get_html(driver=driver, text="//h2[contains(text(), 'Đối tượng')]/following-sibling::*",type="xpath"),
            "lich_tiem" : get_html(driver=driver,text="//h2[contains(text(), 'Phác đồ')]/following-sibling::*",type="xpath"),
            "phan_ung" : get_html(driver=driver, text="//h2[contains(text(), 'Phản ứng sau tiêm')]/following-sibling::*",type="xpath"),
            "slug" : u['slug'],
            'image' : u['image']
        }
        data.append(d)

    with open("vaccines.csv", mode="w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=data[0].keys())
        writer.writeheader()
        writer.writerows(data)
    driver.quit()

vaccin_info()