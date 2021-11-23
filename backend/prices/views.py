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

from .serializers import CountrySerializer, FoodSerializer, ItemCategorySerializer, KindSerializer, PriceSerializer, FoodCommentSerializer, FoodProductRanksSerializer, ProductClsSerializer, ProductRankSerializer, UnitSerializer
from .models import Country, Food, ItemCategory, Kind, Price, FoodComment, FoodProductRanks, ProductCls, ProductRank, Unit

from .modules import Scrap, duration, logging

import datetime
import json

import timeit

from copy import deepcopy

import asyncio


class InitDatabase(APIView):
    """
    KAMIS 규칙에 따라 데이터베이스를 초기화 합니다.
    부류, 품목, 품종, 등급 테이블 및 지역, 도/소매 테이블이 영향을 받습니다.

    request 시 body에 mode를 요청해야합니다.
    사용 가능한 mode는 다음과 같습니다.
    ('country', 'productcls', 'productrank', 'itemcategory', 'food', 'kind', 'foodproductranks', 'all')
    """

    def __init__(self):
        import pandas as pd

        self.item_category_code_form = pd.read_excel('code.xlsx', sheet_name='부류코드', skiprows=[0])
        self.item_code_form          = pd.read_excel('code.xlsx', sheet_name='품목코드', skiprows=[0])
        self.kind_code_form          = pd.read_excel('code.xlsx', sheet_name='품종코드', skiprows=[0])
        self.rank_code_form          = pd.read_excel('code.xlsx', sheet_name='등급코드', skiprows=[0])

        kind_codes = self.kind_code_form['품종코드'].astype(str)
        kind_codes = kind_codes.apply(lambda x: "{:0>2s}".format(x))
        self.kind_code_form['품종코드'] = kind_codes
        self.rank_code_form = self.rank_code_form.dropna(axis=0, subset=['등급코드(p_productrankcode)'])
        rank_codes = self.rank_code_form['등급코드(p_productrankcode)'].astype(int).astype(str)
        rank_codes = rank_codes.apply(lambda x: "{:0>2s}".format(x))
        self.rank_code_form['등급코드(p_productrankcode)'] = rank_codes

        self.scrap = Scrap()


    @duration
    def init_country(self):
        countries = {'서울': 1101, '부산': 2100, '대구': 2200,
                     '광주': 2401, '대전': 2501, '인천': 2300,
                     '울산': 2601, '수원': 3111, '춘천': 3211, 
                     '청주': 3311, '전주': 3511, '포항': 3711,
                     '제주': 3911, '순천': 3613, '안동': 3714,
                     '창원': 3814, '용인': 3145, '의정부': 3113,
                     '세종': 2701, '강릉': 3214}
                     # (세종, 강릉)은 홈페이지에 최신화 안되어있음.
                     # 충주, 목포, 마산 등 country code가 등록되어있지 않은 지역구가 존재함.
        
        for country, country_code in countries.items():
            serializer = CountrySerializer(data={'country_code': country_code, 'country': country})
            if serializer.is_valid(raise_exception=True):
                serializer.save()
    

    @duration
    def init_unit(self):
        units = ['kg', '포기', '개', '리터', '마리', '장', '속', '접']
        for unit in units:
            serializer = UnitSerializer(data={'unit': unit})
            if serializer.is_valid(raise_exception=True):
                serializer.save()
    

    @duration
    def init_product_cls(self):
        for product_cls_code, product_cls in (('01', '소매'), ('02', '도매')):
            serializer = ProductClsSerializer(data={'product_cls_code': product_cls_code,
                                                    'product_cls': product_cls})
            if serializer.is_valid(raise_exception=True):
                serializer.save()
    

    @duration
    def init_product_rank(self):
        for product_rank_code, grade_rank, product_rank in zip(self.rank_code_form['등급코드(p_productrankcode)'],
                                                               self.rank_code_form['등급코드(p_graderank)'],
                                                               self.rank_code_form['등급코드명']):
            serializer = ProductRankSerializer(data={'product_rank_code': product_rank_code,
                                                     'grade_rank': grade_rank,
                                                     'product_rank': product_rank})
            if serializer.is_valid(raise_exception=True):
                serializer.save()
    

    @duration
    def init_item_category(self):
        for item_category_code, item_category in zip(self.item_category_code_form['부류코드'],
                                                     self.item_category_code_form['부류명']):
            serializer = ItemCategorySerializer(data={'item_category_code': item_category_code,
                                                      'item_category': item_category})
            if serializer.is_valid(raise_exception=True):
                serializer.save()


    @duration
    def init_food(self):
        # excel 파일 품목표가 최신화가 되어있지 않아 품종표로 대체함.
        foods = [food for food in self.kind_code_form['품목명']]
        images = self.scrap.loop.run_until_complete(self.scrap.get_google_images(foods))

        for idx, item_code in enumerate(self.kind_code_form['품목 코드']):
            item_category = item_code // 100 * 100
            if Food.objects.filter(item_code=item_code):
                continue

            serializer = FoodSerializer(data={'item_code': item_code,
                                              'item_category': item_category,
                                              'food': foods[idx],
                                              'image': images[idx]})
            if serializer.is_valid(raise_exception=True):
                serializer.save()
    

    @duration
    def init_kind(self):
        for food, kind_code, kind in zip(self.kind_code_form['품목 코드'],
                                         self.kind_code_form['품종코드'],
                                         self.kind_code_form['품종명']):
            serializer = KindSerializer(data={'food': food,
                                              'kind_code': kind_code,
                                              'kind': kind})
            if serializer.is_valid(raise_exception=True):
                serializer.save()


    @duration
    def init_food_product_ranks(self):
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
            countries           = Country.objects.all()
            serializer          = CountrySerializer(countries, many=True)
        
        elif request.POST['mode'] == 'unit':
            self.init_unit()
            unit                = Unit.objects.all()
            serializer          = UnitSerializer(unit, many=True)
        
        elif request.POST['mode'] == 'productcls':
            self.init_product_cls()
            product_cls         = ProductCls.objects.all()
            serializer          = ProductClsSerializer(product_cls, many=True)
        
        elif request.POST['mode'] == 'productrank':
            self.init_product_rank()
            product_ranks       = ProductRank.objects.all()
            serializer          = ProductRankSerializer(product_ranks, many=True)

        elif request.POST['mode'] == 'itemcategory':
            self.init_item_category()
            item_categories     = ItemCategory.objects.all()
            serializer          = ItemCategorySerializer(item_categories, many=True)
        
        elif request.POST['mode'] == 'food':
            self.init_food()
            foods               = Food.objects.all()
            serializer          = FoodSerializer(foods, many=True)

        elif request.POST['mode'] == 'kind':
            self.init_kind()
            kinds               = Kind.objects.all()
            serializer          = KindSerializer(kinds, many=True)

        elif request.POST['mode'] == 'foodproductranks':
            self.init_foodproductranks()
            food_product_ranks  = FoodProductRanks.objects.all()
            serializer          = FoodProductRanksSerializer(food_product_ranks, many=True)
        
        elif request.POST['mode'] == 'all':
            self.init_country()
            self.init_unit()
            self.init_product_cls()
            self.init_product_rank()
            self.init_item_category()
            self.init_food()
            self.init_kind()
            self.init_food_product_ranks()
            response = {'success': 'Every tables are init!'}

            return JsonResponse(response)
        
        else:
            response = {'error': 'Invalid request body.'}

            return JsonResponse(response)

        return Response(serializer.data)
    
    
    def delete(self, request):
        """테이블 내용 삭제"""

        FoodProductRanks.objects.all().delete()
        Kind.objects.all().delete()
        Food.objects.all().delete()
        ItemCategory.objects.all().delete()
        ProductRank.objects.all().delete()
        ProductCls.objects.all().delete()
        Unit.objects.all().delete()
        Country.objects.all().delete()

        response = {'success': 'Every tables are deleted.'}
        return JsonResponse(response)


class DataPipeline(APIView):
    """prices/data-pipeline/"""

    def __init__(self):
        self.scrap = Scrap()
        with open('secret.json', 'r') as f:
            __cert_key, __cert_id = json.load(f).values()
        self.scrap.kamis_setting(cert_key=__cert_key, cert_id=__cert_id)
        self.new_country_code = self.country_code_generator()
    

    def country_code_generator(self):
        country_code = 0
        defined_country_codes = Country.objects.values_list('country_code')
        while True:
            country_code += 1
            if (country_code,) in defined_country_codes:
                continue
            yield country_code


    def insert_undefined_country(self, country):
        country_code = next(self.new_country_code)
        Country.objects.create(country_code=country_code, country=country)
        logging.info(f"Country '{country}' is created. (country_code={country_code})")
        return country_code
    

    @duration
    def insert_prices(self, params_list, responses):

        price = Price()
        countries = Country.objects.all()

        for idx, response in enumerate(responses):
            logging.info(f'Prograss... {idx}%')
            if response == None: continue
            data_list = []

            price.food_id         = params_list[idx]['p_itemcode']
            price.product_rank_id = params_list[idx]['p_productrankcode']
            price.product_cls_id  = params_list[idx]['p_productclscode']

            kinds = Kind.objects.filter(food=price.food_id)

            for item in response:
                if item['countyname'] in ('평균', '평년'): continue

                *kind, unit   = item['kindname'].split('(')
                kind_name     = '('.join(kind) if type(kind) == list else kind
                price.kind_id = kinds.get(kind=kind_name).pk
                price.unit_id = unit[1:-1]

                country = countries.filter(country=item['countyname'])
                if country.exists():
                    price.country_id = country[0].pk
                else:
                    price.country_id = self.insert_undefined_country(item['countyname'])
                    countries = Country.objects.all()
                    
                price.date   = item['yyyy'] + '-' + item['regday'].replace('/', '-')
                price.market = item['marketname']
                price.price  = int(item['price'].replace(',', '')) if item['price'].replace(',', '').isdigit() else -1

                data_list.append(deepcopy(price))
                
            try:
                Price.objects.bulk_create(data_list)
            except Exception as e:
                logging.info(f"Serializer Error: {e}")


    # @login_required
    # @permission_required('admin')
    @duration
    def post(self, request):
        """
        # Request::
        itemcode, productrankcode (247)
            startday, endday (1996.1.1 ~ 2021.12.31 per 100 => t95)
                productclscode (2)
        # Total:: 46,930 request
        """

        food_product_ranks  = FoodProductRanks.objects.values('food', 'product_rank').distinct()
        # startday    = datetime.date(2021, 10, 28)
        startday    = Price.objects.latest('date').date if Price.objects.exists() else datetime.date(1996, 1, 1)
        endday      = datetime.date.today()
        days        = (endday - startday).days
        step        = 100
        params_list = []
        params      = {}

        for food_product_rank in food_product_ranks:
            sday         = startday
            food         = food_product_rank['food']
            product_rank = food_product_rank['product_rank']
            logging.info('{:=^30}'.format(Food.objects.get(item_code=food).food +'/'+ 
                                          ProductRank.objects.get(product_rank_code=product_rank).product_rank))

            params['p_itemcode']        = food
            params['p_productrankcode'] = product_rank

            for eday in (startday + datetime.timedelta(time_delta) for time_delta in range(days % step, days+1, step)):
                logging.info(f"{sday} ~ {eday}")
                params['p_startday'] = sday.__str__()
                params['p_endday']   = eday.__str__()

                for product_cls in ('01', '02'):
                    params['p_productclscode'] = product_cls
                    params_list.append(deepcopy(params))

                    if len(params_list) >= 100:
                        responses = self.scrap.loop.run_until_complete(self.scrap.get_all_kamis_data(params_list))
                        self.insert_prices(params_list, responses)
                        params_list = []

                sday = eday + datetime.timedelta(days=1)

        if params_list != []:
            responses = self.scrap.loop.run_until_complete(self.scrap.get_all_kamis_data(params_list))
            self.insert_prices(params_list, responses)
        self.scrap.loop.close()

        response = {'success': 'Data has been updated.'}
        return JsonResponse(response)
    

    def delete(self, request):
        result = Price.objects.all().delete()
        response = {'success': f'{result[0]} Price data has been deleted.'}
        return JsonResponse(response)


class FoodListView(APIView):
    """prices/foods/"""

    def get(self, request):
        """
        모든 음식 데이터 전송
        """
        foods = Food.objects.all()#.order_by(request.data['order'])
        serializer = FoodSerializer(foods, many=True)
        return Response(serializer.data)


class FoodDetailView(APIView):
    pass


class PricesView(APIView):
    """prices/foods/<pk:int>/prices
    상품의 가격 정보 반환"""

    def get(self, request, item_code):
        req = {key:value for key, value in request.GET.items()}
        prices     = Price.objects.filter(food=item_code, **req).order_by('-date')
        serializer = PriceSerializer(prices, many=True)
        return Response(serializer.data)


@require_http_methods(['GET'])
@duration
def food_table(request):
    foods = Food.objects.values('item_code', 'food')
    for food in foods:
        try:
            food.setdefault('price', Price.objects.filter(food=food['item_code']).latest('id').price)
        except:
            food.setdefault('price', '-')
    return JsonResponse(list(foods), safe=False)