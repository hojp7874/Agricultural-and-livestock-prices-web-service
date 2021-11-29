from rest_framework import serializers
from .models import ItemCategory, Food, Kind, Country, ProductRank, ProductCls, Price, FoodComment#, Unit#, FoodProductRanks
from accounts.serializers import UserSerializer


class ItemCategorySerializer(serializers.ModelSerializer):

    class Meta:
        model   = ItemCategory
        fields  = "__all__"


class KindSerializer(serializers.ModelSerializer):

    class Meta:
        model   = Kind
        fields  = "__all__"


class CountrySerializer(serializers.ModelSerializer):

    class Meta:
        model   = Country
        fields  = "__all__"


class ProductRankSerializer(serializers.ModelSerializer):

    class Meta:
        model   = ProductRank
        fields  = "__all__"


# class FoodProductRanksSerializer(serializers.ModelSerializer):

#     class Meta:
#         model   = FoodProductRanks
#         fields  = "__all__"


class ProductClsSerializer(serializers.ModelSerializer):

    class Meta:
        model   = ProductCls
        fields  = "__all__"


# class UnitSerializer(serializers.ModelSerializer):

#     class Meta:
#         model   = Unit
#         fields  = "__all__"


    # prices      = PriceSerializer(many=True, read_only=True)
    # like_users  = UserSerializer(many=True, read_only=True)
class FoodSerializer(serializers.ModelSerializer):
    kinds = KindSerializer(many=True, read_only=True)
    # countries = CountrySerializer(many=True, read_only=True)
    # product_ranks = FoodProductRanksSerializer(many=True, read_only=True)
    # item_category = ItemCategorySerializer()

    class Meta:
        model   = Food
        exclude = ['like_users']
        # fields  = "__all__"


class PriceSerializer(serializers.ModelSerializer):

    class Meta:
        model   = Price
        fields  = "__all__"


class FoodCommentSerializer(serializers.ModelSerializer):

    class Meta:
        model   = FoodComment
        fields  = "__all__"