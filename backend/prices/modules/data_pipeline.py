from bs4 import BeautifulSoup
import requests
import pandas as pd


def get_soup(url, params, parser='html.parser'):
    headers  = {'User-Agent' : 'Mozilla/5.0'}
    response = requests.get(url, headers=headers, params=params)
    return BeautifulSoup(response.content, parser)

class Kamis:
    """
    Kamis에서 식료품 정보를 추출합니다.
    INFO: https://www.kamis.or.kr/customer/reference/openapi_list.do
    """

    def __init__(self, cert_key: int, cert_id: str):
        """
        Kamis 서비스를 이용하기 위해 사이트에서 발급받은 key와 id를 입력합니다.
        """

        self.__cert_key = cert_key
        self.cert_id    = cert_id
        self.returntype = 'json'
        self.request_url = 'http://www.kamis.or.kr/service/price/xml.do'

        code = pd.read_excel('code.xlsx', sheet_name='코드통합(부류＋품목＋품종코드)')
        for c in code.items():
            print(c)
        self.productcls_code    = {
            '소매': '01',
            '도매': '02'
        }
        self.item_code          = {

        }
        self.productrank_code   = {

        }
        # self.country_code       = {
        #     '서울': 1101,
        #     '부산': 2100,
        #     '대구': 2200,
        #     '광주': 2401,
        #     '대전': 2501,
        #     '인천': 2300,
        #     '울산': 2601,
        #     '수원': 3111,
        #     '춘천': 3211,
        #     '청주': 3311,
        #     '전주': 3511,
        #     '포항': 3711,
        #     '제주': 3911,
        #     '의정부': 3113,
        #     '순천': 3613,
        #     '안동': 3714,
        #     '창원': 3814,
        #     '용인': 3145
        # }
    
    def search(self, startday, endday, productcls, item, productrank):
        params = {
            'action':'periodProductList',
            'p_cert_key': self.__cert_key,
            'p_cert_id': self.cert_id,
            'p_return_type': self.returntype,
            'p_startday': startday,
            'p_endday': endday,
            'p_productclscode': self.productcls_code[productcls],
            'p_itemcode': self.item_code[item],
            'p_productrankcode': self.productrank_code[productrank],
        }

        res = get_soup(self.request_url, params)
        print(res)


if __name__ == '__main__':
    kamis = Kamis(1, 'test')
