from bs4 import BeautifulSoup
import requests
import asyncio
from concurrent.futures import ThreadPoolExecutor

class Scrap:

    def __init__(self):
        self.loop   = asyncio.new_event_loop()
        self.url    = None

    def kamis_setting(self, cert_key: str, cert_id: str):
        self.url            = 'http://www.kamis.or.kr/service/price/xml.do'
        self.action         = 'periodProductList'
        self.__cert_key     = cert_key
        self.__cert_id      = cert_id
        self.returntype     = 'json'
        self.convert_kg_yn  = 'Y'

    async def fetch(self, mode, executor, url, parser='html.parser'):
        """
        image, kamis 두 가지 mode가 있습니다.
        image: google에서 검색한 이미지를 가져옵니다.
        kamis: kamis(농산물 유통정보 사이트)에서 식품 가격정보를 가져옵니다.
        """

        res = await self.loop.run_in_executor(executor, requests.get, url)
        if res.status_code != 200: return None

        if mode == 'image':
            soup    = BeautifulSoup(res.content, parser)
            image   = soup.find("img", {"class": "yWs4tf"}).get('src')
            return image
        elif mode == 'kamis':
            res = res.json()
            if   res['data'] == ['200']:    raise Exception("Wrong Parameters.")
            elif res['data'] == ['900']:    raise Exception("Unauthenticated request.")
            elif res['data'] == ['001']:    return None
            else:                           return res['data']['item']

    async def main(self, mode, urls):
        executor    = ThreadPoolExecutor(max_workers=100)
        with ThreadPoolExecutor(max_workers=100) as executor:
            futures = (asyncio.ensure_future(self.fetch(mode, executor, url)) for url in urls)
            result  = await asyncio.gather(*futures)

        return result

    def get_google_images(self, search_texts):
        urls    = [f'https://www.google.com/search?q={search_text}&tbm=isch' for search_text in search_texts]
        result  = self.loop.run_until_complete(self.main(mode='image', urls=urls))
        return result

    def urlmaker(self, params):
        return self.url + '?' + '&'.join(f'{key}={value}' for key, value in params.items())
    
    def get_kamis_datas(self, params_var_list: dict):
        """
        kamis api로 요청을 보냅니다.

        필수 params는 다음과 같습니다.
        p_startday, p_endday, p_productclscode, p_itemcode, p_productrankcode

        선택 params는 다음과 같습니다.
        p_itemcategorycode, p_kindcode, p_countrycode, p_convert_kg_yn
        """

        print('Getting Kamis Data...')

        params_const = {
            'action'          : self.action,
            'p_cert_key'      : self.__cert_key,
            'p_cert_id'       : self.__cert_id,
            'p_returntype'    : self.returntype,
            'p_convert_kg_yn' : self.convert_kg_yn
        }
        params_list = map(lambda params_var: dict(params_const, **params_var), params_var_list)
        urls        = map(self.urlmaker, params_list)
        result      = self.loop.run_until_complete(self.main(mode='kamis', urls=urls))
        
        print('...OK')
        return result


if __name__ == "__main__":
    scrap = Scrap()
    # print(scrap.get_google_images(['사과', '딸기', '복숭아']))
    scrap.kamis_setting('1', '1')
    test_range = list(range(1000, 4000))
    countries = {'서울': 1101, '부산': 2100, '대구': 2200,
                '광주': 2401, '대전': 2501, '인천': 2300,
                '울산': 2601, '수원': 3111, '춘천': 3211, 
                '청주': 3311, '전주': 3511, '포항': 3711,
                '제주': 3911, '순천': 3613, '안동': 3714,
                '창원': 3814, '용인': 3145, '의정부': 3113,
                '세종': 2701, '강릉': 3214}
    for country in countries.values():
        test_range.remove(country)
    print(scrap.get_kamis_datas([{'p_startday': '2021-10-27', 'p_endday': '2021-10-28', 'p_productclscode': '01', 'p_itemcode': 111, 'p_productrankcode': '04', 'p_countrycode': countrycode} for countrycode in test_range]))
