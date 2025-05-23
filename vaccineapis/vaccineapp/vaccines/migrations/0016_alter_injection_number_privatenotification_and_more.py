# Generated by Django 5.2 on 2025-05-09 09:01

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('vaccines', '0015_remove_vaccine_manual_remove_vaccine_origin_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='injection',
            name='number',
            field=models.IntegerField(blank=True, default=1, null=True),
        ),
        migrations.CreateModel(
            name='PrivateNotification',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=255)),
                ('message', models.TextField()),
                ('notification_date', models.DateTimeField(auto_now_add=True)),
                ('is_read', models.BooleanField(default=False)),
                ('injection', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='notifications', to='vaccines.injection')),
            ],
            options={
                'verbose_name': 'Thông báo',
                'verbose_name_plural': 'Thông báo',
                'ordering': ['-notification_date'],
            },
        ),
        migrations.CreateModel(
            name='PublicNotification',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=255)),
                ('message', models.TextField()),
                ('notification_date', models.DateTimeField(auto_now_add=True)),
                ('vaccine_campaign', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='public_notification', to='vaccines.vaccinationcampaign')),
            ],
            options={
                'ordering': ['-notification_date'],
                'abstract': False,
            },
        ),
        migrations.CreateModel(
            name='NotificationStatus',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('is_read', models.BooleanField(default=False)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='notification_status', to=settings.AUTH_USER_MODEL)),
                ('public_notification', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='notification_status', to='vaccines.publicnotification')),
            ],
            options={
                'indexes': [models.Index(fields=['user', 'is_read'], name='vaccines_no_user_id_5a165c_idx')],
                'unique_together': {('user', 'public_notification')},
            },
        ),
    ]
