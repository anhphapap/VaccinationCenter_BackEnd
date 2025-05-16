@echo off
REM Kích hoạt môi trường ảo (điều chỉnh đường dẫn tới môi trường ảo của bạn)
call D:\VaccinationCenter_BackEnd\venv\Scripts\activate.bat

REM Dừng các tiến trình celery đang chạy (nếu có)
echo Dung cac tien trinh celery dang chay...
taskkill /F /IM celery.exe 2>NUL

REM Xóa các file celerybeat-schedule cũ nếu cần
echo Dang don dep file schedule cu...
del /F /Q celerybeat-schedule 2>NUL
del /F /Q celerybeat-schedule-shm 2>NUL
del /F /Q celerybeat-schedule-wal 2>NUL

REM Đợi 3 giây để đảm bảo tất cả đã dừng
timeout /t 3

REM Khởi động Celery worker
echo Khoi dong Celery worker...
start cmd /k "celery -A vaccineapp worker -l info --concurrency=2 --purge"

REM Đợi worker khởi động
timeout /t 5

REM Khởi động Celery beat
echo Khoi dong Celery beat...
start cmd /k "celery -A vaccineapp beat -l info"


echo Celery da duoc khoi dong! 

