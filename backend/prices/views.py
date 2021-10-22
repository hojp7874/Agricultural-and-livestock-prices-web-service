from django.shortcuts import render
from django.views.generic import View, FormView, CreateView, UpdateView, DeleteView
from django.contrib.auth.decorators import permission_required, login_required

from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import generics

from .serializers import FoodSerializer, PriceSerializer, FoodCommentSerializer
from .models import Food, Price, FoodComment

# from .modules.data_pipelines import Kamis
import datetime

def data_pipeline(request):
    """
    prices/data-pipeline/
    """
    foods = Food.objects.all().order_by('item_code')
    ## Request::
    # startday, endday
    # productclscode
    # itemcode
    # productrankcode

    for food in foods:
        print(food.__dict__)
        startday = Price.objects.latest('date') if Price.objects.exists() else datetime.date(1996, 1, 1)
        endday = datetime.date.today()
        days = (endday - startday).days
        step = 3000
        sday = startday
        for eday in (startday + datetime.timedelta(time_delta) for time_delta in range(days % step, days+1, step)):
            print(sday, eday)
            
            sday = eday + datetime.timedelta(days=1)
        # for day in :
        #     pass
        # price_serializer = PriceSerializer(food=food.pk, kind=)
    return 1


class FoodListView(APIView):
    """
    prices/foods/
    """
    def get(self, request):
        """
        모든 음식 데이터 전송
        """
        foods = Food.objects.all().order_by(request.data['order'])
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


class FoodDetailView(APIView):
    pass


class PricesView(APIView):
    """
    prices/foods/<pk:int>/prices
    상품의 가격 정보 반환
    """
    def get(self, request, item_code):
        kind_code       = request.data['kind_code']
        product_rank    = request.data['product_rank']
        country         = request.data['country']
        product_cls     = request.data['product_cls']
        prices          = Price.objects.all().filter(food=item_code)
        serializer      = PriceSerializer(prices, many=True)
        return Response(serializer.data)