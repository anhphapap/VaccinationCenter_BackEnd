from rest_framework import serializers
from vaccines.models import Category, Vaccine


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
