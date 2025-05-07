from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
from vaccines.models import Category, Vaccine, VaccinationCampaign, Dose, Injection
from django.utils import timezone
from datetime import timedelta

User = get_user_model()


class Command(BaseCommand):
    help = 'Seed test data for vaccination system'

    def handle(self, *args, **kwargs):
        # Create categories
        categories = [
            Category.objects.create(
                name='Vắc xin cho trẻ em', image='child_vaccine.jpg'),
            Category.objects.create(
                name='Vắc xin cho người lớn', image='adult_vaccine.jpg'),
            Category.objects.create(
                name='Vắc xin phòng COVID-19', image='covid_vaccine.jpg')
        ]

        # Create vaccines
        vaccines = [
            Vaccine.objects.create(
                id='VAC001',
                name='Vắc xin 6 trong 1',
                description='Vắc xin phòng 6 bệnh: bạch hầu, ho gà, uốn ván, bại liệt, viêm gan B, viêm màng não mủ',
                origin='Bỉ',
                injection='Tiêm bắp',
                recommend='Trẻ em từ 2 tháng tuổi',
                manual='Tiêm 3 mũi cách nhau 1 tháng',
                preserve='Bảo quản ở 2-8 độ C',
                patient='Trẻ em khỏe mạnh',
                effects='Sốt nhẹ, đau tại chỗ tiêm',
                disease='Bạch hầu, ho gà, uốn ván, bại liệt, viêm gan B, viêm màng não mủ',
                country='Bỉ',
                image='6in1.jpg',
                price=1200000
            ),
            Vaccine.objects.create(
                id='VAC002',
                name='Vắc xin COVID-19 Pfizer',
                description='Vắc xin phòng COVID-19',
                origin='Mỹ',
                injection='Tiêm bắp',
                recommend='Người từ 12 tuổi trở lên',
                manual='Tiêm 2 mũi cách nhau 21 ngày',
                preserve='Bảo quản ở -70 độ C',
                patient='Người khỏe mạnh',
                effects='Sốt nhẹ, đau tại chỗ tiêm',
                disease='COVID-19',
                country='Mỹ',
                image='pfizer.jpg',
                price=1500000
            )
        ]

        # Add categories to vaccines
        vaccines[0].cates.add(categories[0])
        vaccines[1].cates.add(categories[1], categories[2])

        # Create doses for vaccines
        for vaccine in vaccines:
            if vaccine.name == 'Vắc xin 6 trong 1':
                Dose.objects.create(
                    vaccine=vaccine, number=1, days_after_previous=0)
                Dose.objects.create(
                    vaccine=vaccine, number=2, days_after_previous=30)
                Dose.objects.create(
                    vaccine=vaccine, number=3, days_after_previous=30)
            else:  # COVID-19 vaccine
                Dose.objects.create(
                    vaccine=vaccine, number=1, days_after_previous=0)
                Dose.objects.create(
                    vaccine=vaccine, number=2, days_after_previous=21)

        # Create test user
        user = User.objects.create_user(
            username='testuser',
            password='testpass123',
            email='test@example.com',
            first_name='Test',
            last_name='User',
            birth_date=timezone.now().date() - timedelta(days=365*25),
            phone='0123456789',
            address='123 Test Street',
            is_completed_profile=True
        )

        # Create vaccination campaign
        campaign = VaccinationCampaign.objects.create(
            name='Đợt tiêm chủng mở rộng 2024',
            description='Đợt tiêm chủng mở rộng cho trẻ em và người lớn',
            start_date=timezone.now(),
            end_date=timezone.now() + timedelta(days=30),
            vaccine=vaccines[0]
        )

        # Create test injection
        injection = Injection.objects.create(
            vaccine=vaccines[0],
            user=user,
            vaccination_campaign=campaign,
            injection_time=timezone.now() + timedelta(days=1),
            number=1
        )

        self.stdout.write(self.style.SUCCESS('Successfully seeded test data'))
