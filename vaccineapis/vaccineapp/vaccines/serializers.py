from rest_framework import serializers
from vaccines.models import Category, Vaccine, User, VaccinationCampaign, Dose, Injection
import re


class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'


class VaccineSerializer(serializers.ModelSerializer):
    cates = serializers.SerializerMethodField()

    class Meta:
        model = Vaccine
        fields = ['id', 'name', 'origin', 'disease', 'image', 'price', 'cates']

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

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['avatar'] = instance.avatar
        return data
    # validate password

class UserRegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True, required=True,
                                     error_messages={'required': 'Bạn phải nhập mật khẩu'})
    confirm_password = serializers.CharField(write_only=True, required=True,
                                             error_messages={'required': 'Bạn phải xác nhận mật khẩu'})

    class Meta:
        model = User
        fields = ['username', 'password', 'confirm_password']
        extra_kwargs = {
            'username': {
                'required': True,
                'error_messages': {
                    'required': 'Bạn phải nhập tên đăng nhập'
                }
            },
            'password': {'write_only': True},
        }

    def validate(self, data):
        if data['password'] != data['confirm_password']:
            raise serializers.ValidationError(
                {"confirm_password": "Mật khẩu xác nhận không khớp"})
        return data

    def validate_password(self, password):
        if len(password) < 8:
            raise serializers.ValidationError(
                "Mật khẩu phải có ít nhất 8 ký tự")
        if not re.search(r'[A-Za-z]', password) and not re.search(r'[0-9]', password):
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
        if not re.search(r'[A-Za-z]', value) and not re.search(r'[0-9]', value):
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


class InjectionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Injection
        fields = ['id', 'vaccine', 'user', 'vaccination_campaign',
                  'injection_time', 'number', 'active']
        read_only_fields = ['id', 'active']


class DoseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Dose
        fields = '__all__'


class VaccinationCampaignSerializer(serializers.ModelSerializer):
    class Meta:
        model = VaccinationCampaign
        fields = '__all__'
