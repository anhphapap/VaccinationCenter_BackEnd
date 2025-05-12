import os
from celery import Celery
from celery.schedules import crontab

# Set the default Django settings module for the 'celery' program.
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'vaccineapp.settings')

app = Celery('vaccineapp')

# Using a string here means the worker doesn't have to serialize
# the configuration object to child processes.
app.config_from_object('django.conf:settings', namespace='CELERY')

# Load task modules from all registered Django app configs.
app.autodiscover_tasks()
@app.task(name='vaccines.tasks.send_injection_reminder')
def send_injection_reminder():
    # Chỉ là proxy task, gọi đến hàm thực tế trong vaccines.tasks
    from vaccines.tasks import send_injection_reminder as real_task
    return real_task()
# Configure periodic tasks
app.conf.beat_schedule = {
    'send-injection-reminder': {
        'task': 'vaccines.tasks.send_injection_reminder',
        'schedule': crontab(minute='*/1'),  # Run every minute
    },
}
