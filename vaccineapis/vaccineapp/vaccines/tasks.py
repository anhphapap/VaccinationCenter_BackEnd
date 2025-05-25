from celery import shared_task
from django.conf import settings
from django.utils import timezone
from datetime import timedelta

import redis
from .models import Injection, PrivateNotification, VaccinationCampaign, User, PublicNotification, NotificationStatus


@shared_task(name='vaccines.tasks.send_injection_reminder')
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

        # Create notification in database
        PrivateNotification.objects.create(
            user=injection.user,
            injection=injection,
            title=title,
            message=message
        )


@shared_task(name='vaccines.tasks.update_campaign_status')
def update_campaign_status():
    now = timezone.now()
    active_campaigns = VaccinationCampaign.objects.filter(active=True)

    for campaign in active_campaigns:
        if campaign.end_date.date() < now.date():
            campaign.active = False
            campaign.save()


@shared_task(name='vaccines.tasks.update_missed_injections')
def update_missed_injections():
    now = timezone.now()

    missed_injections = Injection.objects.filter(
        injection_time__lt=now,
        status='NOT_VACCINATED',
        active=True
    ).select_related('user', 'vaccine')

    for injection in missed_injections:
        injection.status = 'MISSED'
        injection.save()

        # Send notification for missed injection
        title = f"THÔNG BÁO: Bỏ lỡ lịch tiêm {injection.vaccine.name}"
        message = f"Bạn đã bỏ lỡ lịch tiêm {injection.vaccine.name} vào {injection.injection_time.strftime('%H:%M, ngày %d/%m/%Y')}. "
        message += "Vui lòng liên hệ với trung tâm để được tư vấn lịch tiêm mới."

        PrivateNotification.objects.create(
            user=injection.user,
            injection=injection,
            title=title,
            message=message
        )


@shared_task(name='vaccines.tasks.warm_up_redis')
def warm_up_redis():
    r = redis.Redis.from_url(settings.REDIS_URL)
    r.ping()
