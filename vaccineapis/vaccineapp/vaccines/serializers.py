from rest_framework import serializers
from vaccines.models import Category, Vaccine, User
import re

class CategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'


class VaccineSerializer(serializers.ModelSerializer):
    cates = serializers.SerializerMethodField()

    class Meta:
        model = Vaccine
        fields = ['id', 'name', 'origin', 'image', 'price', 'cates']

    def get_cates(self, vaccine):
        return [{'id': category.id, 'name': category.name} for category in vaccine.cates.all()]


class VaccineDetailSerializer(VaccineSerializer):
    class Meta:
        model = Vaccine
        fields = VaccineSerializer.Meta.fields


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'username', 'email', 'password']
        extra_kwargs = {
            'password': {'write_only': True}
        }

    #validate username
    def validate_username(self, value):
        if User.objects.filter(username=value).exists():
            raise serializers.ValidationError("Tên người dùng đã tồn tại, vui lòng chọn tên khác")
        return value
    
    #validate password
    def validate_password(self, value):
        if len(value) < 8:
            raise serializers.ValidationError("Mật khẩu phải có ít nhất 8 ký tự")
        if not re.search(r'[A-Za-z]', value) and not re.search(r'[0-9]', value):
            raise serializers.ValidationError("Mật khẩu phải có ít nhất 1 chữ cái và 1 số")
        return value

    #validate email
    def validate_email(self, value):
        if value == '':
            raise serializers.ValidationError("Email không được để trống")
        return value

    def create(self, validated_data):
        user = User(**validated_data)
        user.set_password(validated_data['password'])
        user.save()
        return user
