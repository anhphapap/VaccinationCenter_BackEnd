
import pandas as pd
import mysql.connector

# Kết nối đến Railway MySQL
conn = mysql.connector.connect(

)

cursor = conn.cursor()

# Hàm xử lý dữ liệu rỗng
def clean(val):
    return val if pd.notnull(val) else ''

# Đọc file CSV
df = pd.read_csv('vaccine_new.csv', encoding='utf-8')

# Câu lệnh UPDATE (sử dụng %s để tránh lỗi cú pháp do HTML)
sql = """
    UPDATE vaccines_vaccine
    SET `country` = %s,
        `description` = %s,
        `origin` = %s,
        `injection` = %s,
        `recommend` = %s,
        `manual` = %s,
        `preserve` = %s,
        `patient` = %s,
        `effects` = %s
    WHERE id = %s
"""

updated_count = 0
skipped = 0

for index, row in df.iterrows():
    try:
        values = (
            clean(row['country']),
            clean(row['description']),
            clean(row['origin']),
            clean(row['injection']),
            clean(row['recommend']),
            clean(row['manual']),
            clean(row['preserve']),
            clean(row['patient']),
            clean(row['effects']),
            clean(row['id']) 
        )
        cursor.execute(sql, values)
        updated_count += 1
    except Exception as e:
        print(f"⚠️ Lỗi tại dòng {index + 1}: {e}")
        skipped += 1

conn.commit()
cursor.close()
conn.close()

print(f"✅ Đã cập nhật {updated_count} dòng.")
print(f"⚠️ Bỏ qua {skipped} dòng do lỗi.")
