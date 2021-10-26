from django.shortcuts import render
from django.views.generic import View, FormView, CreateView, UpdateView, DeleteView
from django.contrib.auth.decorators import permission_required, login_required
from django.views.decorators.http import require_http_methods
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from django.http import JsonResponse

from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import generics

from .serializers import CountrySerializer, FoodSerializer, ItemCategorySerializer, KindSerializer, PriceSerializer, FoodCommentSerializer, FoodProductRanksSerializer, ProductClsSerializer, ProductRankSerializer
from .models import Country, Food, ItemCategory, Kind, Price, FoodComment, FoodProductRanks, ProductCls, ProductRank

from .modules import get_google_image, Kamis

import datetime
import json


class InitDatabase(APIView):
    """
    KAMIS 규칙에 따라 데이터베이스를 초기화 합니다.
    부류, 품목, 품종, 등급 테이블 및 지역, 도/소매 테이블이 영향을 받습니다.
    """

    def __init__(self):
        import pandas as pd

        self.item_category_code_form    = pd.read_excel('code.xlsx', sheet_name='부류코드', skiprows=[0])
        self.item_code_form             = pd.read_excel('code.xlsx', sheet_name='품목코드', skiprows=[0])
        self.kind_code_form             = pd.read_excel('code.xlsx', sheet_name='품종코드', skiprows=[0])
        self.rank_code_form             = pd.read_excel('code.xlsx', sheet_name='등급코드', skiprows=[0])

        kind_codes = self.kind_code_form['품종코드'].astype(str)
        kind_codes = kind_codes.apply(lambda x: "{:0>2s}".format(x))
        self.kind_code_form['품종코드'] = kind_codes

        self.rank_code_form             = self.rank_code_form.dropna(axis=0, subset=['등급코드(p_productrankcode)'])
        rank_codes = self.rank_code_form['등급코드(p_productrankcode)'].astype(int).astype(str)
        rank_codes = rank_codes.apply(lambda x: "{:0>2s}".format(x))
        self.rank_code_form['등급코드(p_productrankcode)'] = rank_codes

    def init_country(self):
        countries = {'서울': 1101, '부산': 2100, '대구': 2200,
                     '광주': 2401, '대전': 2501, '인천': 2300,
                     '울산': 2601, '수원': 3111, '춘천': 3211, 
                     '청주': 3311, '전주': 3511, '포항': 3711,
                     '제주': 3911, '순천': 3613, '안동': 3714,
                     '창원': 3814, '용인': 3145, '의정부': 3113}
        
        for country, country_code in countries.items():
            serializer = CountrySerializer(data={'country_code': country_code, 'country': country})
            if serializer.is_valid(raise_exception=True):
                serializer.save()
    
    def init_product_cls(self):
        for product_cls_code, product_cls in (('01', '소매'), ('02', '도매')):
            serializer = ProductClsSerializer(data={'product_cls_code': product_cls_code,
                                                    'product_cls': product_cls})
            if serializer.is_valid(raise_exception=True):
                serializer.save()
    
    def init_product_rank(self):
        for product_rank_code, grade_rank, product_rank in zip(self.rank_code_form['등급코드(p_productrankcode)'],
                                                               self.rank_code_form['등급코드(p_graderank)'],
                                                               self.rank_code_form['등급코드명']):
            serializer = ProductRankSerializer(data={'product_rank_code': product_rank_code,
                                                     'grade_rank': grade_rank,
                                                     'product_rank': product_rank})
            if serializer.is_valid(raise_exception=True):
                serializer.save()
    
    def init_item_category(self):
        for item_category_code, item_category in zip(self.item_category_code_form['부류코드'],
                                                     self.item_category_code_form['부류명']):
            serializer = ItemCategorySerializer(data={'item_category_code': item_category_code,
                                                      'item_category': item_category})
            if serializer.is_valid(raise_exception=True):
                serializer.save()

    def init_food(self):
        ## excel 파일 품목표가 최신화가 안되어있어 품종표로 대체함.-----------------------
        # for item_category, item_code, food in zip(self.item_code_form['부류코드'],
        #                                           self.item_code_form['품목코드'],
        #                                           self.item_code_form['품목명']):
        for item_code, food in zip(self.kind_code_form['품목 코드'],
                                   self.kind_code_form['품목명']):
            item_category = item_code // 100 * 100
            if Food.objects.filter(item_code=item_code):
                continue
        ## ------------------------------------------------------------------------
        
            image = get_google_image(food)
            serializer = FoodSerializer(data={'item_code': item_code,
                                              'item_category': item_category,
                                              'food': food,
                                              'image': image})
            if serializer.is_valid(raise_exception=True):
                serializer.save()
    
    def init_kind(self):
        for food, kind_code, kind in zip(self.kind_code_form['품목 코드'],
                                         self.kind_code_form['품종코드'],
                                         self.kind_code_form['품종명']):
            serializer = KindSerializer(data={'food': food,
                                              'kind_code': kind_code,
                                              'kind': kind})
            if serializer.is_valid(raise_exception=True):
                serializer.save()

    def init_foodproductranks(self):
        for food, kind_code, *product_ranks in zip(self.kind_code_form['품목 코드'],
                                              self.kind_code_form['품종코드'],
                                              self.kind_code_form['도매 등급'],
                                              self.kind_code_form['소매 등급'],
                                              self.kind_code_form["친환경 등급('05~'20.3)"],
                                              self.kind_code_form["친환경 등급('20.4~)"]):
            kind = Kind.objects.get(food=food, kind_code=kind_code).pk
            product_ranks = ','.join((rank for rank in product_ranks if type(rank) == str))
            for product_rank in set(product_ranks.split(',')):
                serializer = FoodProductRanksSerializer(data={'food': food,
                                                              'kind': kind,
                                                              'product_rank': product_rank})
                if serializer.is_valid(raise_exception=True):
                    serializer.save()

    def post(self, request):
        if request.POST['mode'] == 'country':
            self.init_country()
            countries = Country.objects.all()
            serializer = CountrySerializer(countries, many=True)
        
        elif request.POST['mode'] == 'productcls':
            self.init_product_cls()
            product_cls = ProductCls.objects.all()
            serializer = ProductClsSerializer(product_cls, many=True)
        
        elif request.POST['mode'] == 'productrank':
            self.init_product_rank()
            product_ranks = ProductRank.objects.all()
            serializer = ProductRankSerializer(product_ranks, many=True)

        elif request.POST['mode'] == 'itemcategory':
            self.init_item_category()
            item_categories = ItemCategory.objects.all()
            serializer = ItemCategorySerializer(item_categories, many=True)
        
        elif request.POST['mode'] == 'food':
            self.init_food()
            foods = Food.objects.all()
            serializer = FoodSerializer(foods, many=True)

        elif request.POST['mode'] == 'kind':
            self.init_kind()
            kinds = Kind.objects.all()
            serializer = KindSerializer(kinds, many=True)

        elif request.POST['mode'] == 'foodproductranks':
            self.init_foodproductranks()
            food_product_ranks = FoodProductRanks.objects.all()
            serializer = FoodProductRanksSerializer(food_product_ranks, many=True)
        
        elif request.POST['mode'] == 'all':
            self.init_country()
            self.init_product_cls()
            self.init_product_rank()
            self.init_item_category()
            self.init_food()
            self.init_kind()
            self.init_foodproductranks()
            response = {'success': 'Every table is init!'}
            return JsonResponse(response)
        
        else:
            response = {'error': 'Invalid request body.'}
            return JsonResponse(response)
        
        return Response(serializer.data)


class DataPipeline(APIView):
    """prices/data-pipeline/"""

    def __init__(self):
        with open('secret.json', 'r') as f:
            __cert_key, __cert_id = json.load(f).values()
        self.kamis = Kamis(cert_key=__cert_key, cert_id=__cert_id)

    def post(self, request):
        foods = Food.objects.all().order_by('item_code')
        ## Request::
        # itemcode
        # startday, endday
        # productrankcode
        # productclscode

        for food in foods:
            startday = Price.objects.latest('date') if Price.objects.exists() else datetime.date(2021, 10, 21)
            endday = datetime.date.today()
            days = (endday - startday).days
            step = 100
            sday = startday
            for eday in (startday + datetime.timedelta(time_delta) for time_delta in range(days % step, days+1, step)):
                # print(sday, eday)
                productranks = food.product_ranks.all()
                for productrankcode in productranks:
                    for productclscode in ['01', '02']:

                        params = {
                            'p_startday': sday.__str__(),
                            'p_endday': eday.__str__(),
                            'p_productclscode': productclscode,
                            'p_itemcode': food.pk,
                            'p_productrankcode': productrankcode.product_rank_id,
                        }
                        print(params)
                        response = self.kamis.get_data(params)
                        if response == None:
                            continue
                        for res in response:
                            # print(res)
                            pass
                        # serializer = PriceSerializer(food=food.pk,
                        #                              kind=,
                        #                              country=,
                        #                              product_rank=,
                        #                              product_cls=,
                        #                              date=,
                        #                              market=,
                        #                              price=)
                print('-'*50)
                sday = eday + datetime.timedelta(days=1)
            # for day in :
            #     pass
            # price_serializer = PriceSerializer(food=food.pk, kind=)
            prices = Price.objects.all()
            serializer = PriceSerializer(prices, many=True)
        return Response(serializer.data)


def data_pipeline(request):
    """prices/data-pipeline/"""

    foods = Food.objects.all().order_by('item_code')
    ## Request::
    # itemcode
    # startday, endday
    # productrankcode
    # productclscode

    for food in foods:
        startday = Price.objects.latest('date') if Price.objects.exists() else datetime.date(1996, 1, 1)
        endday = datetime.date.today()
        days = (endday - startday).days
        step = 3000
        sday = startday
        for eday in (startday + datetime.timedelta(time_delta) for time_delta in range(days % step, days+1, step)):
            # print(sday, eday)
            food_product_ranks = food.product_ranks
            print(food_product_ranks)
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