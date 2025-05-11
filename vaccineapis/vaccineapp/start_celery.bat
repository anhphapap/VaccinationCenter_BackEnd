@echo off
call D:\VaccinationCenter_BackEnd\venv\Scripts\activate.bat
start cmd /k "celery -A vaccineapp worker -l info"
start cmd /k "celery -A vaccineapp beat -l info"