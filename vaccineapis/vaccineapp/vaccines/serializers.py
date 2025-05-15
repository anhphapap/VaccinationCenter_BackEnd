from rest_framework import serializers
from vaccines.models import Category, Vaccine, User, VaccinationCampaign, Dose, Injection, Notification, PublicNotification, PrivateNotification, NotificationStatus
import re


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'


class VaccineSerializer(serializers.ModelSerializer):
    cates = serializers.SerializerMethodField()

    class Meta:
        model = Vaccine
        fields = '__all__'

    def get_cates(self, vaccine):
        return [{'id': category.id, 'name': category.name} for category in vaccine.cates.all()]


class VaccineDetailSerializer(serializers.ModelSerializer):
    cates = serializers.SerializerMethodField()
    doses = serializers.SerializerMethodField()

    class Meta:
        model = Vaccine
        fields = '__all__'

    def get_cates(self, vaccine):
        return [{'id': category.id, 'name': category.name} for category in vaccine.cates.all()]

    def get_doses(self, vaccine):
        return [{'id': dose.id, 'number': dose.number, 'days_after_previous': dose.days_after_previous, 'note': dose.note} for dose in vaccine.doses.all()]


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'
        extra_kwargs = {
            "password": {"write_only": True}
        }


class UserRegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, required=True,
                                     error_messages={'required': 'Bạn phải nhập mật khẩu'})

    class Meta:
        model = User
        fields = ['username', 'password']
        extra_kwargs = {
            'username': {
                'required': True,
                'error_messages': {
                    'required': 'Bạn phải nhập tên đăng nhập'
                }
            },
        }

    def validate_password(self, password):
        if len(password) < 8:
            raise serializers.ValidationError(
                "Mật khẩu phải có ít nhất 8 ký tự")
        if not re.search(r'[A-Za-z]', password) or not re.search(r'[0-9]', password):
            raise serializers.ValidationError(
                "Mật khẩu phải có ít nhất 1 chữ cái và 1 số")
        return password

    def create(self, validated_data):
        user = User(**validated_data)
        user.set_password(validated_data['password'])
        user.save()
        return user

    def to_internal_value(self, data):
        try:
            return super().to_internal_value(data)
        except serializers.ValidationError as exc:
            errors = exc.detail
            if 'username' in errors:
                for i, msg in enumerate(errors['username']):
                    if 'already exists' in msg or 'unique' in msg:
                        errors['username'][i] = "Tên đăng nhập đã tồn tại!"
            raise serializers.ValidationError(errors)


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['first_name', 'last_name', 'email',
                  'phone', 'address', 'birth_date', 'gender']
        extra_kwargs = {
            'phone': {
                'required': True,
                'error_messages': {
                    'required': 'Bạn phải nhập số điện thoại'
                }
            },
            'first_name': {
                'required': True,
                'error_messages': {
                    'required': 'Bạn phải nhập họ'
                }
            },
            'last_name': {
                'required': True,
                'error_messages': {
                    'required': 'Bạn phải nhập tên'
                }
            },
            'address': {
                'required': True,
                'error_messages': {
                    'required': 'Bạn phải nhập địa chỉ'
                }
            },
            'email': {
                'required': True,
                'error_messages': {
                    'required': 'Bạn phải nhập email'
                }
            },
            'avatar': {
                'required': True,
                'error_messages': {
                    'required': 'Bạn phải tải ảnh đại diện'
                }
            }
        }

# serializers.py


class ChangePasswordSerializer(serializers.Serializer):
    old_password = serializers.CharField(required=True,
                                         error_messages={'required': 'Bạn phải nhập mật khẩu cũ'})
    new_password = serializers.CharField(required=True,
                                         error_messages={'required': 'Bạn phải nhập mật khẩu mới'})

    def validate_new_password(self, value):
        if len(value) < 8:
            raise serializers.ValidationError(
                "Mật khẩu phải có ít nhất 8 ký tự")
        if not re.search(r'[A-Za-z]', value) or not re.search(r'[0-9]', value):
            raise serializers.ValidationError(
                "Mật khẩu phải có ít nhất 1 chữ cái và 1 số")
        return value

    def update(self, instance, validated_data):
        for attr, value in validated_data.items():
            if attr == 'new_password':
                instance.set_password(value)
            else:
                setattr(instance, attr, value)

        instance.save()
        return instance


class VaccinationCampaignSerializer(serializers.ModelSerializer):
    class Meta:
        model = VaccinationCampaign
        fields = '__all__'

    def create(self, validated_data):
        campaign = VaccinationCampaign.objects.create(**validated_data)

        public_notification = PublicNotification.objects.create(
            title=f"Đợt tiêm mới: {campaign.name}",
            message=f"Đã có đợt tiêm mới: {campaign.name}. "
            f"Thời gian: từ {campaign.start_date.strftime('%d/%m/%Y')} đến {campaign.end_date.strftime('%d/%m/%Y')}. "
            f"{campaign.description}",
            vaccine_campaign=campaign
        )

        NotificationStatus.objects.create(
            user=self.context['request'].user,
            public_notification=public_notification,
            is_read=False
        )

        return campaign


class InjectionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Injection
        fields = '__all__'

    def validate(self, data):
        user = data.get('user')
        campaign = data.get('vaccination_campaign')

        if campaign.id != 1:
            existing_injection = Injection.objects.filter(
                user=user,
                vaccination_campaign=campaign,
                active=True
            ).select_related('vaccination_campaign').first()

            if existing_injection:
                raise serializers.ValidationError(
                    {"error": "Bạn đã đăng ký đợt tiêm cộng đồng này trước đó"})
        return data


class DoseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Dose
        fields = '__all__'


class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Notification
        fields = '__all__'
        read_only_fields = ['notification_date']


class PrivateNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = PrivateNotification
        fields = ['id', 'title', 'message',
                  'notification_date', 'is_read', 'injection']
        read_only_fields = ['notification_date']


class PublicNotificationSerializer(serializers.ModelSerializer):
    is_read = serializers.SerializerMethodField()

    class Meta:
        model = PublicNotification
        fields = ['id', 'title', 'message',
                  'notification_date', 'vaccine_campaign', 'is_read']
        read_only_fields = ['notification_date']

    def get_is_read(self, obj):
        user = self.context['request'].user
        try:
            status = NotificationStatus.objects.get(
                user=user, public_notification=obj)
            return status.is_read
        except NotificationStatus.DoesNotExist:
            return False


class NotificationStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = NotificationStatus
        fields = ['id', 'public_notification', 'is_read']
