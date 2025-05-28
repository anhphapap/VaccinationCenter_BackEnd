import csv
from vaccines.models import Vaccine
from django.db import transaction

with open('D:\\VaccinationCenter_BackEnd\\CrawData\\vaccines_new2.csv', newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile)
    with transaction.atomic():
        for row in reader:
            Vaccine.objects.filter(id=row['id']).update(
                description=row['description'],
                patient=row['patient'],
                injection=row['injection'],
                effects=row['effects']
            )
