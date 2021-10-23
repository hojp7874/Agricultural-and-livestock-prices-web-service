from bs4 import BeautifulSoup
import requests
import pandas as pd
from ..models import FoodProductRanks
from ..serializers import FoodProductRanksSerializer


class InitDatabase:
    """
    부류, 품목, 품종
    Kamis 규칙에 따라 데이터베이스를 초기화 합니다.
    """

    def __init__(self):
        self.code_form = pd.read_excel('code.xlsx', sheet_name='코드통합(부류＋품목＋품종코드)', skiprows=[0])
        self.code_form = self.code_form.drop(columns='Unnamed: 0')

    def init_country(self):
        pass

    def init_food(self):
        pass

    def init_foodproductranks(self):
        for row in zip(self.code_form['품목 코드'], 
                       self.code_form['품종코드'], 
                       self.code_form['도매 등급'], 
                       self.code_form['소매 등급'], 
                       self.code_form["친환경 등급('05~'20.3)"], 
                       self.code_form["친환경 등급('20.4~)"]):
                       
            product_ranks = ','.join((rank for rank in row[2:] if type(rank) == str))
            for product_rank in product_ranks.split(','):
                serializer = FoodProductRanksSerializer(food=row[0], kind=row[1], product_rank=product_rank)
                if serializer.is_valid():
                    pass


if __name__ == '__main__':
    init_db = InitDatabase()
    print(init_db.code_form)
    init_db.init_foodproductranks()