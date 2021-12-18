# 표준 라이브러리 모듈
import asyncio, datetime, json, math
from copy import deepcopy
from dateutil.relativedelta import relativedelta

# 서드 파티 모듈
from django.db.models import Count
from django.shortcuts import render
from django.views.generic import View, FormView, CreateView, UpdateView, DeleteView
from django.contrib.auth.decorators import permission_required, login_required
from django.views.decorators.http import require_http_methods
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from django.http import JsonResponse

from rest_framework.response import Response
from rest_framework.decorators import api_view, renderer_classes
from rest_framework.renderers import JSONRenderer
from rest_framework.views import APIView
from rest_framework import generics

# 기타 모듈
from .serializers import CountrySerializer, FoodSerializer, ItemCategorySerializer, KindSerializer, PriceSerializer, FoodCommentSerializer, ProductClsSerializer, ProductRankSerializer, PriceConditionSerializer
from .models import Country, Food, ItemCategory, Kind, Price, FoodComment, ProductCls, ProductRank, PriceCondition
from .modules import Scrap, duration, logging


class InitDatabase(APIView): # Google Image CSS 스타일 변경으로 인해 레거시 됨.
    """
    현재 (food, all) mode 불가.

    KAMIS 규칙에 따라 데이터베이스를 초기화 합니다.
    부류, 품목, 품종, 등급 테이블 및 지역, 도/소매 테이블이 영향을 받습니다.

    request 시 body에 mode를 요청해야합니다.
    사용 가능한 mode는 다음과 같습니다.
    ('country', 'productcls', 'productrank', 'itemcategory',\
    'food', 'kind', 'pricecondition', 'all')
    """

    def __init__(self):
        import pandas as pd

        self.item_category_code_form = pd.read_excel('code.xlsx',
                                                     sheet_name='부류코드',
                                                     skiprows=[0])
        self.item_code_form = pd.read_excel('code.xlsx',
                                            sheet_name='품목코드',
                                            skiprows=[0])
        self.kind_code_form = pd.read_excel('code.xlsx',
                                            sheet_name='품종코드',
                                            skiprows=[0])
        self.rank_code_form = pd.read_excel('code.xlsx',
                                            sheet_name='등급코드',
                                            skiprows=[0])

        kind_codes = self.kind_code_form['품종코드'].astype(str)
        kind_codes = kind_codes.apply(lambda x: "{:0>2s}".format(x))
        self.kind_code_form['품종코드'] = kind_codes
        self.rank_code_form = self.rank_code_form.dropna(
            axis=0, subset=['등급코드(p_productrankcode)'])
        rank_codes = self.rank_code_form['등급코드(p_productrankcode)'
                                        ].astype(int).astype(str)
        rank_codes = rank_codes.apply(lambda x: "{:0>2s}".format(x))
        self.rank_code_form['등급코드(p_productrankcode)'] = rank_codes

        self.scrap = Scrap()

    @duration
    def init_country(self):
        countries = {'서울': 1101, '부산': 2100, '대구': 2200,
                     '인천': 2300, '광주': 2401, '대전': 2501, 
                     '울산': 2601, '세종': 2701, '수원': 3111,
                     '의정부': 3113,'용인': 3145, '춘천': 3211, 
                     '강릉': 3214, '청주': 3311, '전주': 3511,
                     '순천': 3613, '포항': 3711, '안동': 3714,
                     '창원': 3814, '제주': 3911}
        
        for country, country_code in countries.items():
            serializer = CountrySerializer(data={'country_code': country_code,
                                                 'country': country})
            if serializer.is_valid(raise_exception=True):
                serializer.save()

    @duration
    def init_product_cls(self):
        for product_cls_code, product_cls in (('01', '소매'), ('02', '도매')):
            serializer = ProductClsSerializer(
                    data={'product_cls_code': product_cls_code,
                          'product_cls': product_cls})
            if serializer.is_valid(raise_exception=True):
                serializer.save()

    @duration
    def init_item_category(self):
        for item_category_code, item_category in zip(
                self.item_category_code_form['부류코드'],
                self.item_category_code_form['부류명']):
            serializer = ItemCategorySerializer(
                data={'item_category_code': item_category_code,
                      'item_category': item_category})
            if serializer.is_valid(raise_exception=True):
                serializer.save()


    @duration
    def init_food(self):
        # excel 파일 품목표가 최신화가 되어있지 않아 품종표로 대체함.

        # foods = [food for food in self.kind_code_form['품목명']]
        # images = self.scrap.loop.run_until_complete(
        #     self.scrap.get_google_images(foods))
        for item_code, food, wholesale_unit, wholesale_val, retail_unit, \
            retail_val in zip(self.kind_code_form['품목 코드'],
                              self.kind_code_form['품목명'],
                              self.kind_code_form['도매출하단위'],
                              self.kind_code_form['도매출하단위 크기'],
                              self.kind_code_form['소매출하단위'],
                              self.kind_code_form['소매출하단위 크기']):
            if Food.objects.filter(item_code=item_code):
                continue

            wholesale_unit = (
                None if math.isnan(wholesale_val)
                else str(wholesale_val) + wholesale_unit)
            retail_unit = (
                None if math.isnan(retail_val)
                else str(retail_val) + retail_unit)
            if wholesale_unit == retail_unit == None:
                continue

            item_category = item_code // 100 * 100
            serializer = FoodSerializer(
                data={'item_code': item_code,
                      'item_category': item_category,
                      'food': food,
                      'wholesale_unit': wholesale_unit,
                      'retail_unit': retail_unit,
                      #'image': images[idx]})
                      'image': 'No Image'})
            if serializer.is_valid(raise_exception=True):
                serializer.save()

    @duration
    def init_kind(self):
        for food, kind_code, kind in zip(self.kind_code_form['품목 코드'],
                                         self.kind_code_form['품종코드'],
                                         self.kind_code_form['품종명']):
            if Food.objects.filter(item_code=food).exists():
                serializer = KindSerializer(data={'food': food,
                                                'kind_code': kind_code,
                                                'kind': kind})
                if serializer.is_valid(raise_exception=True):
                    serializer.save()

    @duration
    def init_product_rank(self):
        for product_rank_code, grade_rank, product_rank in zip(
                self.rank_code_form['등급코드(p_productrankcode)'],
                self.rank_code_form['등급코드(p_graderank)'],
                self.rank_code_form['등급코드명']):
            serializer = ProductRankSerializer(
                data={'product_rank_code': product_rank_code,
                      'grade_rank': grade_rank,
                      'product_rank': product_rank})
            if serializer.is_valid(raise_exception=True):
                serializer.save()
        
        for food, kind_code, *product_rank_codes in zip(
                self.kind_code_form['품목 코드'],
                self.kind_code_form['품종코드'],
                self.kind_code_form['도매 등급'],
                self.kind_code_form['소매 등급'],
                self.kind_code_form["친환경 등급('05~'20.3)"],
                self.kind_code_form["친환경 등급('20.4~)"]):
            kind_check = Kind.objects.filter(food=food, kind_code=kind_code)
            if kind_check.exists():
                kind = kind_check[0]
            else:
                continue
            product_rank_codes = set(','.join((
                rank for rank in product_rank_codes if type(rank) is str
            )).split(','))
            for product_rank_code in product_rank_codes:
                product_rank = ProductRank.objects.get(
                    product_rank_code=product_rank_code)
                product_rank.kinds.add(kind)
    
    @duration
    def init_price_condition(self):
        kinds = Kind.objects.values_list('id')
        countries = Country.objects.values_list('country_code')
        product_ranks = ProductRank.objects.values_list('product_rank_code')
        product_clss = ProductCls.objects.values_list('product_cls_code')

        price_conditions = [PriceCondition(
            kind_id=kind[0],
            country_id=country[0],
            product_rank_id=product_rank[0],
            product_cls_id=product_cls[0]
        )
        for kind in kinds
        for country in countries
        for product_rank in product_ranks
        for product_cls in product_clss]

        PriceCondition.objects.bulk_create(price_conditions,
                                           ignore_conflicts=False)

    def post(self, request):
        if request.POST['mode'] == 'country':
            self.init_country()
            countries = Country.objects.all()
            serializer = CountrySerializer(countries, many=True)
        
        elif request.POST['mode'] == 'productcls':
            self.init_product_cls()
            product_cls = ProductCls.objects.all()
            serializer = ProductClsSerializer(product_cls, many=True)

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
        
        elif request.POST['mode'] == 'productrank':
            self.init_product_rank()
            product_ranks = ProductRank.objects.all()
            serializer = ProductRankSerializer(product_ranks, many=True)

        elif request.POST['mode'] == 'pricecondition':
            self.init_price_condition()
            price_conditions = PriceCondition.objects.all()
            serializer = PriceConditionSerializer(price_conditions, many=True)

        elif request.POST['mode'] == 'all':
            self.init_country()
            self.init_product_cls()
            self.init_item_category()
            self.init_food()
            self.init_kind()
            self.init_product_rank()
            self.init_price_condition()
            response = {'success': 'Every tables are init!'}

            return JsonResponse(response)
        
        else:
            response = {'error': 'Invalid request body.'}

            return JsonResponse(response)

        return Response(serializer.data)
    
    def delete(self, request):
        """테이블 초기데이터 삭제"""

        PriceCondition.objects.all().delete()
        ProductRank.objects.all().delete()
        Kind.objects.all().delete()
        Food.objects.all().delete()
        ItemCategory.objects.all().delete()
        ProductCls.objects.all().delete()
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
        country_code = 9000
        defined_country_codes = Country.objects.values_list('country_code')
        while True:
            country_code += 1
            if (country_code,) in defined_country_codes:
                continue
            yield country_code

    def insert_undefined_country(self, country):
        country_code = next(self.new_country_code)
        Country.objects.create(country_code=country_code, country=country)
        logging.info(
            f"Country '{country}' is created. (country_code={country_code})")
        return country_code
    
    @duration
    def insert_prices(self, price_condition, responses):
        len_res = len(responses)

        data_list = []

        for idx, response in enumerate(responses):
            logging.info(f'Prograss... ({idx}/{len_res})')
            if response is None:
                continue

            for item in response:
                if item['countyname'] in ('평균', '평년'):
                    continue

                price_value = item['price'].replace(',', '')
                if not price_value.isdigit():
                    continue

                price = int(price_value)
                date = item['yyyy'] + '-' + item['regday'].replace('/', '-')

                data_list.append(Price(
                    price=price,
                    date=date,
                    condition=price_condition
                ))

        if data_list:
            try:
                Price.objects.bulk_create(data_list, ignore_conflicts=True)
                logging.info(f'{len(data_list)}개의 데이터가 저장되었습니다.')
            except Exception as e:
                logging.info(f"Data Save Error: {e}")

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

        ## KAMIS API BLOCKED: 1년 내의 데이터만 요청 가능
        # date_list = []
        # sday = datetime.date(1996,1,1)
        # delta = relativedelta(years=1, days=-1)
        # eday = sday + delta
        # while sday <= datetime.date.today():
        #     date_list.append((sday.__str__(), eday.__str__()))
        #     sday += delta
        #     eday += delta
        date_list = [(
            datetime.date.today() - relativedelta(years=1),
            datetime.date.today())]

        price_conditions = PriceCondition.objects.all()

        start_idx = 0
        for idx, price_condition in enumerate(price_conditions):
            if price_condition.prices.exists():
                start_idx = idx+1
                
        if start_idx == len(price_conditions):
            return JsonResponse({'success': 'Data has been updated.'})

        price_conditions = price_conditions[start_idx:]

        for price_condition in price_conditions:
            
            params_list = [{
                'p_itemcode': price_condition.kind.food_id,
                'p_kindcode': price_condition.kind.kind_code,
                'p_productrankcode': price_condition.product_rank_id,
                'p_productclscode': price_condition.product_cls_id,
                'p_countrycode': price_condition.country_id,
                'p_startday': startday,
                'p_endday': endday
            } for startday, endday in date_list]
            
            responses = asyncio.run(
                self.scrap.get_all_kamis_data(params_list))
            self.insert_prices(price_condition, responses)

        return JsonResponse({'success': 'Data has been updated.'})

@api_view(['PUT'])
def check_valid_price_condition(request):
    """prices/price-condition/price-exists/
    유효한 조건(가격 정보가 있는 조건)을 표시합니다."""

    price_conditions = PriceCondition.objects.all()
    for price_condition in price_conditions:
        if price_condition.prices.exists():
            price_condition.prices_exists = True
            price_condition.save()
    
    result = price_conditions.filter(prices_exists=True)
    serializer = PriceConditionSerializer(result)
    return Response(serializer.data)

@api_view(['GET'])
def get_countries(request):
    """prices/countries/
    모든 지역 데이터를 반환합니다."""

    countries = Country.objects.all()
    serializer = CountrySerializer(countries, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def get_foods(request):
    """prices/foods/
    모든 음식 데이터를 반환합니다."""

    foods = Food.objects.all()
    serializer = FoodSerializer(foods, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def get_food_detail(request, item_code):
    """prices/foods/<pk:int>/
    품목의 세부정보 반환"""

    food = Food.objects.get(item_code=item_code)
    serializer = FoodSerializer(food)
    return Response(serializer.data)

@require_http_methods(['GET'])
def prices_conditions(request, item_code):
    """prices/foods/<pk:int>/prices-conditions/
    가격 검색 조건 리스트 반환"""
    
    price_conditions = PriceCondition.objects.all()
    exist_price_conditions = list(filter(
        lambda x: x.prices.exists(), price_conditions))

    prices_condition_list = Price.objects.filter(food=item_code
        ).values('kind', 'product_rank', 'product_cls', 'country'
        ).annotate(Count('id')
        ).values('food', 'kind', 'product_rank', 'product_cls', 'country')
    return JsonResponse(list(prices_condition_list), safe=False)

@api_view(['GET'])
def get_prices(request, item_code):
    """prices/foods/<pk:int>/prices/
    조건에 해당되는 prices를 반환합니다."""

    condition = json.loads(request.GET['condition'])
    price_condition = PriceCondition.objects.get(**condition)
    prices = price_condition.prices
    serializer = PriceSerializer(prices, many=True)
    return Response(serializer.data)

@require_http_methods(['GET'])
@duration
def food_table(request):
    """prices/food-table/
    food 목록 반환"""

    foods = Food.objects.values('item_code', 'food')
    # N+1.
    # 1) Add price_last, price_month, price_year field
    # for food in foods:
    #     try:
    #         food.setdefault('price',
    #                         Price.objects.filter(
    #                             food=food['item_code']).latest('id').price)
    #     except:
    #         food.setdefault('price', '-')
    return JsonResponse(list(foods), safe=False)
