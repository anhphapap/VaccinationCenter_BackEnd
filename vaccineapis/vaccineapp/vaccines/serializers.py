from rest_framework import serializers
from vaccines.models import Category, Vaccine, User, VaccinationCampaign, Dose, Injection, Notification, PublicNotification, PrivateNotification, NotificationStatus, Order, OrderDetail
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
            "password": {"write_only": True},
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


class UserRegisterSerializer(serializers.ModelSerializer):
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
            'password': {
                'write_only': True,
                'required': True,
                'error_messages': {
                    'required': 'Bạn phải nhập mật khẩu'
                }
            }
        }

    def validate_password(self, password):
        if len(password) < 8:
            raise serializers.ValidationError(
                'Mật khẩu phải có ít nhất 8 ký tự')
        if not re.search(r'[A-Za-z]', password) or not re.search(r'[0-9]', password):
            raise serializers.ValidationError(
                'Mật khẩu phải có ít nhất 1 chữ cái và 1 số')
        return password

    def create(self, validated_data):
        user = User(**validated_data)
        user.set_password(validated_data['password'])
        user.save()
        return user



class ChangePasswordSerializer(serializers.ModelSerializer):
    old_password = serializers.CharField()
    new_password = serializers.CharField()


    class Meta:
        model = User
        fields = ['old_password', 'new_password']
        extra_kwargs = {
            'old_password': {
                'write_only': True,
                'required': True,
                'error_messages': {
                    'required': 'Bạn phải nhập mật khẩu cũ'
                }
            },
            'new_password': {
                'write_only': True,
                'required': True,
                'error_messages': {
                    'required': 'Bạn phải nhập mật khẩu mới'
                }
            }
        }
    def validate_new_password(self, value):
        if len(value) < 8:
            raise serializers.ValidationError(
                "Mật khẩu phải có ít nhất 8 ký tự")
        if not re.search(r'[A-Za-z]', value) or not re.search(r'[0-9]', value):
            raise serializers.ValidationError(
                "Mật khẩu phải có ít nhất 1 chữ cái và 1 số")
        return value

    def update(self, instance, validated_data):
        old_password = validated_data.get('old_password')
        new_password = validated_data.get('new_password')

        if not instance.check_password(old_password):
            raise serializers.ValidationError(
                {'error': 'Mật khẩu cũ không đúng'})

        instance.set_password(new_password)
        instance.save()
        return instance


class VaccinationCampaignSerializer(serializers.ModelSerializer):
    class Meta:
        model = VaccinationCampaign
        fields = '__all__'


class InjectionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Injection
        fields = '__all__'

    def validate(self, data):
        user = data.get('user')
        campaign = data.get('vaccination_campaign')

        if campaign.id != 1:
            injection = Injection.objects.filter(
                user=user,
                vaccination_campaign=campaign,
                active=True
            ).select_related('vaccination_campaign').first()

            if injection:
                raise serializers.ValidationError(
                    {"error": "Bạn đã đăng ký đợt tiêm cộng đồng này trước đó"})
        return data

    def create(self, validated_data):
        injection = super().create(validated_data)
        PrivateNotification.objects.create(
            user=injection.user,
            title="Lịch tiêm mới",
            message=f"Bạn có lịch tiêm mới cho vaccine {injection.vaccine.name} vào ngày {injection.injection_time.strftime('%d/%m/%Y')}",
            injection=injection,
            is_read=False
        )

        return injection


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

    def get_is_read(self, noti):
        user = self.context['request'].user
        status = NotificationStatus.objects.get(
            user=user, public_notification=noti)
        return status.is_read


class NotificationStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = NotificationStatus
        fields = ['id', 'public_notification', 'is_read']


class OrderDetailSerializer(serializers.ModelSerializer):
    vaccine = serializers.SerializerMethodField()

    class Meta:
        model = OrderDetail
        fields = ['vaccine', 'unit_price']
    
    def get_vaccine(self, od):
        return od.vaccine.id

class OrderSerializer(serializers.ModelSerializer):
    order_details = OrderDetailSerializer(many=True, read_only=True)

    class Meta:
        model = Order
        fields = ['id', 'created_date', 'updated_date', 'order_id',
                  'amount', 'user', 'vnp_ResponseCode', 'order_details']


class OrderStatusSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = ['id', 'order_id', 'vnp_ResponseCode']
