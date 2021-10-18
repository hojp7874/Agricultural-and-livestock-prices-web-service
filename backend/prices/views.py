from django.shortcuts import render
from django.views.generic import View, FormView, CreateView, UpdateView, DeleteView
from django.contrib.auth.decorators import permission_required, login_required

from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import generics

from .serializers import FoodSerializer, PriceSerializer, FoodCommentSerializer
from .models import Food, Price, FoodComment

from .modules.data_pipelines import Kamis

# Create your views here.
class FoodListView(APIView):
    """
    prices/food/
    """
    def get(self, request):
        """
        모든 음식 데이터 전송
        """
        foods = Food.objects.all().order_by(request.data['key'])
        serializer = FoodSerializer(foods, many=True)
        return Response(serializer.data)
    
    # @login_required
    # @permission_required('admin')
    def post(self, request):
        """
        데이터 파이프라이닝
        음식 데이터 생성 및 DB최신화
        """
        print(request.data)
        serializer = FoodSerializer(data={
            'item_code': 123,
            'name': '딸기'
            })
        if serializer.is_valid(raise_exception=True):
            serializer.save()
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
