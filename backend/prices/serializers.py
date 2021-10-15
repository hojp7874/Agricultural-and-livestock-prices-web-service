from rest_framework import serializers
from .models import Food, Price, FoodComment
from django.conf import settings
from accounts.serializers import UserSerializer


class PriceSerializer(serializers.ModelSerializer):

    class Meta:
        model   = Price
        fields  = "__all__"


class FoodSerializer(serializers.ModelSerializer):
    prices      = PriceSerializer(many=True)
    like_users  = UserSerializer(many=True)
    
    class Meta:
        model   = Food
        fields  = "__all__"


class FoodCommentSerializer(serializers.ModelSerializer):

    class Meta:
        model   = FoodComment
        fields  = "__all__"