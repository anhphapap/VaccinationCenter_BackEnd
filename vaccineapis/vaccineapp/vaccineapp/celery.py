from dotenv import load_dotenv
import os
from celery import Celery
from celery.schedules import crontab


os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'vaccineapp.settings')

app = Celery('vaccineapp')

app.config_from_object('django.conf:settings', namespace='CELERY')
app.conf.timezone = 'Asia/Ho_Chi_Minh'
app.conf.enable_utc = False

app.autodiscover_tasks()
load_dotenv()
