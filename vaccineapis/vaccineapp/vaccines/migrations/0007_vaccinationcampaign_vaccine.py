# Generated by Django 5.2 on 2025-04-27 15:18

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('vaccines', '0006_user_address_user_birth_date_user_gender_user_phone_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='vaccinationcampaign',
            name='vaccine',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='vaccines.vaccine'),
        ),
    ]
