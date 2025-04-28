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
        fields = ['id', 'first_name', 'last_name', 'username',
                    'email', 'password', 'avatar',
                    'phone', 'address', 'birth_date', 'gender', 'is_completed_profile']
        extra_kwargs = {
            'password': {'write_only': True}
        }

    def to_representation(self, instance):
        data = super().to_representation(instance)
        data['avatar'] = instance.avatar
        return data
    # validate password
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


    def update(self, instance, validated_data):
        for attr, value in validated_data.items():
            if attr == 'password':
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
        fields = '__all__'

class DoseSerializer(serializers.ModelSerializer):
    class Meta:
        model = Dose
        fields = '__all__'

class VaccinationCampaignSerializer(serializers.ModelSerializer):
    class Meta:
        model = VaccinationCampaign
        fields = '__all__'



