from django.shortcuts import render
from django.views.generic import View, FormView, CreateView, UpdateView, DeleteView
from django.http import JsonResponse

from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import generics

from .serializers import FoodSerializer, PriceSerializer, FoodCommentSerializer
from .models import Food, Price, FoodComment

# Create your views here.
# class FoodListView(generics.ListAPIView):
#     """
#     /prices
#     모든 음식 데이터 전송
#     """
#     queryset = Food.objects.all()
#     serializer_class = FoodSerializer
class FoodListView(APIView):
    """
    prices/food/
    모든 음식 데이터 전송
    """
    def get(self, request):
        foods = Food.objects.all().order_by(request.data['key'])
        serializer = FoodSerializer(foods, many=True)
        return Response(serializer.data)


class PriceView(APIView):
    """
    prices/food/<pk:int>/
    상품의 가격 정보 반환
    """
    def get(self, request, item_code):
        kind_code       = request.data['kind_code']
        product_rank    = request.data['prpduct_rank']
        country         = request.data['country']
        product_cls     = request.data['product_cls']
        prices          = Price.objects.all().filter(food=item_code)
        serializer      = PriceSerializer(prices, many=True)
        return Response(serializer.data)
