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