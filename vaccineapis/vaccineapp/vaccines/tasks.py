from celery import shared_task
from django.conf import settings
from django.utils import timezone
from datetime import timedelta

import redis
from .models import Injection, PrivateNotification, VaccinationCampaign, User, PublicNotification, NotificationStatus


@shared_task
def send_injection_reminder():
    now = timezone.now()
    tomorrow = now + timedelta(days=1)

    upcoming_injections = Injection.objects.filter(
        injection_time__gte=now,
        injection_time__lte=tomorrow,
        status='NOT_VACCINATED'
    ).select_related('user', 'vaccine')

    for injection in upcoming_injections:
        is_today = injection.injection_time.date() == now.date()

        if is_today:
            title = f"NHẮC NHỞ: Hôm nay là ngày tiêm {injection.vaccine.name}"
            message = f"Bạn có lịch tiêm {injection.vaccine.name} vào hôm nay. "
            message += f"Vui lòng đến đúng giờ và mang theo giấy tờ cần thiết!"
        else:
            title = f"NHẮC NHỞ: Ngày mai là ngày tiêm {injection.vaccine.name}"
            message = f"Bạn có lịch tiêm {injection.vaccine.name} vào ngày mai. "
            message += f"Vui lòng chuẩn bị và đến đúng giờ!"

        PrivateNotification.objects.create(
            user=injection.user,
            injection=injection,
            title=title,
            message=message
        )


@shared_task
def warm_up_redis():
    r = redis.Redis.from_url(settings.REDIS_URL)
    r.ping()  # Hoặc get/set 1 key dummy
