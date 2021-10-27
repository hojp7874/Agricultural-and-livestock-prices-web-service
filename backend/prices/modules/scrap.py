from bs4 import BeautifulSoup
import requests
# from urllib.parse import quote

import asyncio
from concurrent.futures import ThreadPoolExecutor
# import timeit
# from urllib.request import urlopen
# import urllib.parse
# import threading


class Scrap:

    def __init__(self):
        self.loop = asyncio.get_event_loop()
        self.url = None

    def kamis_setting(self, cert_key: str, cert_id: str, returntype: str='json'):
        self.url           = 'http://www.kamis.or.kr/service/price/xml.do'
        self.action        = 'periodProductList'
        self.__cert_key     = cert_key
        self.__cert_id      = cert_id
        self.returntype    = returntype

    async def fetch(self, mode, executor, url, params=None, parser='html.parser'):
        """
        image, kamis 두 가지 mode가 있습니다.
        image: google에서 검색한 이미지를 가져옵니다.
        kamis: kamis(농산물 유통정보 사이트)에서 식품 가격정보를 가져옵니다.
        """

        # headers  = {'User-Agent' : 'Mozilla/5.0'}
        # response = requests.get(url, params=params, headers=headers)
        res = await self.loop.run_in_executor(executor, requests.get, url, params)
        # if response.status_code != 200:
        #     return None
        # if parser == 'json':
        #     return response.json()
        # return BeautifulSoup(response.content, parser)
        if res.status_code != 200:
            return None

        if mode == 'image':
            soup    = BeautifulSoup(res.content, parser)
            image   = soup.find("img", {"class": "yWs4tf"}).get('src')
            return image

        elif mode == 'kamis':
            res     = res.json()
            if   res['data'] == ['200']:
                raise Exception("Wrong Parameters.")
            elif res['data'] == ['900']:
                raise Exception("Unauthenticated request.")
            elif res['data'] == ['001']:
                return None
            else:
                return res['data']['item']

    async def main(self, mode, urls, params=None):
        # 쓰레드 풀 생성
        executor = ThreadPoolExecutor(max_workers=100)
        # future 객체 모아서 gather에서 실행
        futures = (asyncio.ensure_future(self.fetch(mode, executor, url, params)) for url in urls)
        # 결과 취합
        result = await asyncio.gather(*futures)

        return result

    def get_google_images(self, search_texts):
        urls = [f'https://www.google.com/search?q={search_text}&tbm=isch' for search_text in search_texts]
        result = self.loop.run_until_complete(self.main(mode='image', urls=urls))
        return result

    def urlmaker(self, param):
        return self.url + '&'.join(f'{key}={value}' for key, value in param.items())
    
    def get_kamis_datas(self, params_vars: dict):
        """
        kamis api로 요청을 보냅니다.

        필수 params는 다음과 같습니다.
        p_startday, p_endday, p_productclscode, p_itemcode, p_productrankcode

        선택 params는 다음과 같습니다.
        p_itemcategorycode, p_kindcode, p_countrycode, p_convert_kg_yn
        """

        params_const = {
            'action'        : self.action,
            'p_cert_key'    : self.__cert_key,
            'p_cert_id'     : self.__cert_id,
            'p_returntype'  : self.returntype
        }
        params  = map(lambda params_var: dict(params_const, **params_var), params_vars)
        urls    = map(self.urlmaker, params)
        result = self.loop.run_until_complete(self.main(mode='kamis', urls=urls, params=params))
        return result


if __name__ == "__main__":
    scrap = Scrap()
    print(scrap.get_google_images(['사과', '딸기', '복숭아']))
    scrap.kamis_setting(cert_key='keykeykey', cert_id='ididid')
    print(scrap.get_kamis_datas([{'p_startday': '2021-10-25', 'p_endday': '2021-10-27'},
    {'p_startday': '2021-10-22', 'p_endday': '2021-10-24'},
    {'p_startday': '2021-10-19', 'p_endday': '2021-10-21'}]))



def requesting(url, params=None, parser='html.parser'):
    headers  = {'User-Agent' : 'Mozilla/5.0'}
    response = requests.get(url, params=params, headers=headers)
    if response.status_code != 200:
        return None
    if parser == 'json':
        return response.json()
    return BeautifulSoup(response.content, parser)


def get_google_image(search_text: str):
    search_text = search_text
    url         = f'https://www.google.com/search?q={search_text}&tbm=isch'
    soup        = requesting(url)
    image       = soup.find("img", {"class": "yWs4tf"}).get('src')
    return image


class Kamis:
    """Kamis에서 식료품 정보를 가져옵니다."""

    def __init__(self, cert_key: str, cert_id: str, returntype: str='json'):
        self._url           = 'http://www.kamis.or.kr/service/price/xml.do'
        self._action        = 'periodProductList'
        self.__cert_key     = cert_key
        self.__cert_id      = cert_id
        self._returntype    = returntype

    def get_data(self, params_var: dict):
        """
        kamis api로 요청을 보냅니다.

        필수 params는 다음과 같습니다.
        p_startday, p_endday, p_productclscode, p_itemcode, p_productrankcode

        선택 params는 다음과 같습니다.
        p_itemcategorycode, p_kindcode, p_countrycode, p_convert_kg_yn
        """

        params_const = {
            'action'        : self._action,
            'p_cert_key'    : self.__cert_key,
            'p_cert_id'     : self.__cert_id,
            'p_returntype'  : self._returntype
        }
        params      = dict(params_const, **params_var)
        res         = requesting(self._url, params=params, parser='json')
        if   res == None:
            return None
        elif res['data'] == ['200']:
            raise Exception("Wrong Parameters.")
        elif res['data'] == ['900']:
            raise Exception("Unauthenticated request.")
        elif res['data'] == ['001']:
            return None
        else:
            return res['data']['item']

"""
if __name__ == "__main__":
    import json
    from pprint import pprint
    # print(get_google_image('참다래'))
    # print(get_google_image('수입조기'))
    with open('../../secret.json', 'r') as f:
        cert_key, cert_id = json.load(f).values()
    kamis = Kamis(cert_key=cert_key, cert_id=cert_id)

    startday = '1996-01-01'
    endday = '1996-01-03'
    productclscode = '01'
    itemcode = 211
    productrankcode = '04'
    params = {
        'p_startday': startday,
        'p_endday': endday,
        'p_productclscode': productclscode,
        'p_itemcode': itemcode,
        'p_productrankcode': productrankcode,
    }

    pprint(kamis.get_data(params))
"""