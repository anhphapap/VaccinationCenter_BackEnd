@echo off
REM Khởi động Celery worker
start cmd /k "celery -A vaccineapp worker -l info"
REM Khởi động Celery beat
start cmd /k "celery -A vaccineapp beat -l info"