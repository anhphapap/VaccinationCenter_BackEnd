# Generated by Django 5.2 on 2025-05-13 09:04

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('vaccines', '0017_alter_publicnotification_options'),
    ]

    operations = [
        migrations.AddField(
            model_name='privatenotification',
            name='user',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='private_notifications', to=settings.AUTH_USER_MODEL),
        ),
    ]
