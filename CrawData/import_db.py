import csv
import mysql.connector
from datetime import datetime

# Kết nối đến MySQL
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Admin@123',
    database='vaccinedb'
)

cursor = conn.cursor()

# # Import cates
# with open('categories.csv', newline='', encoding='utf-8') as csvfile:
#     reader = csv.DictReader(csvfile)
#     for row in reader:
#         ten = row['ten']
#         image = row['image']
#         cursor.execute(
#             "INSERT INTO vaccines_category (name, image) VALUES (%s, %s)",
#             (ten, image)
#         )

# # Import vaccine
# with open('vaccine_new.csv', newline='', encoding='utf-8') as csvfile:
#     reader = csv.DictReader(csvfile)
#     for row in reader:
#         id = row['slug']
#         image = row['image']
#         name = row['ten']
#         description = row['mo_ta']
#         origin = row['nguon_goc']
#         injection = row['duong_tiem']
#         recommend = row['chong_chi_dinh']
#         manual = row['hdsd']
#         preserve = row['bao_quan']
#         patient = row['doi_tuong']
#         outline = row['lich_tiem']
#         effect = row['phan_ung']
#         if(row['gia'] == ''):
#             price = 0
#         else:
#             price = row['gia']
#         cursor.execute(
#             'INSERT INTO vaccines_vaccine (`id`, `name`, `description`, `origin`, `injection`, `recommend`, `manual`, `preserve`, `patient`, `outline`, `effects`, `image`, `price`, `created_date`, `updated_date`) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)',
#             (id, name, description, origin, injection, recommend, manual, preserve, patient, outline, effect, image, price, datetime.now(), datetime.now())
#         )

# Import vac_cate
with open('vac_cate.csv', newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
       id_cate = row['cate_id']
       id_vac = row['vac_id']
       cursor.execute(
                'INSERT INTO vaccines_vaccine_cates (`vaccine_id`,`category_id`) VALUES (%s, %s)',
                (id_vac, id_cate)
            )

conn.commit()
cursor.close()
conn.close()
