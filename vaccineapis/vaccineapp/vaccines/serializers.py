from rest_framework import serializers
from vaccines.models import Category, Vaccine

class VaccineSerializer(serializers.ModelSerializer):
    class Meta:
        model = Category
        fields = '__all__'
        