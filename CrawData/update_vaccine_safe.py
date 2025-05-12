
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
df = pd.read_csv('vaccines_new2.csv', encoding='utf-8')

# Câu lệnh UPDATE (sử dụng %s để tránh lỗi cú pháp do HTML)
sql = """
    UPDATE vaccines_vaccine
    SET 
        `description` = %s,
        `injection` = %s,
        `patient` = %s,
        `effects` = %s
    WHERE id = %s
"""

updated_count = 0
skipped = 0

for index, row in df.iterrows():
    try:
        values = (
            clean(row['mo_ta']),
            clean(row['lich_tiem']),
            clean(row['doi_tuong']),
            clean(row['phan_ung']),
            clean(row['slug']),
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
