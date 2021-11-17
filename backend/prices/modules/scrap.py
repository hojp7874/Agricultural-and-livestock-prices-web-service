from bs4 import BeautifulSoup
import aiohttp
import asyncio
import timeit
import logging
import json


format = "%(asctime)s: %(message)s"
logging.basicConfig(format=format, level=logging.INFO, datefmt="%H:%M:%S")

def duration(func):
    if asyncio.iscoroutinefunction(func):
        async def inner(*args):
            logging.info(f"{func.__name__.upper()}...")
            start = timeit.default_timer()
            result = await func(*args)
            logging.info(f"Duration {timeit.default_timer() - start}")
            return result
    else:
        def inner(*args):
            logging.info(f"{func.__name__.upper()}...")
            start = timeit.default_timer()
            result = func(*args)
            logging.info(f"Duration {timeit.default_timer() - start}")
            return result
    return inner


class Scrap:
    def __init__(self):
        self.loop = asyncio.new_event_loop()
        self.url  = None


    async def _get_google_image(self, session, search_text):
        url = f"https://www.google.com/search?q={search_text}&tbm=isch"
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:61.0) Gecko/20100101 Firefox/61.0'
        }
        async with session.get(url, headers=headers) as res: # 429 (Too many requests) 발생할 수 있음.
            if res.status != 200: return None
            res_content = await res.text()
            soup = BeautifulSoup(res_content, 'html.parser')
            image = soup.find("img", {"class": "yWs4tf"}).get('src')
        return image


    async def _get_google_images(self, search_texts):
        async with aiohttp.ClientSession() as session:
            images = []
            for search_text in search_texts:
                image = asyncio.ensure_future(self._get_google_image(session, search_text))
                images.append(image)
            return await asyncio.gather(*images, return_exceptions=True)


    def get_google_images(self, search_texts):
        return self.loop.run_until_complete(self._get_google_images(search_texts))


    def kamis_setting(self, cert_key: str, cert_id: str):
        self.url           = 'https://www.kamis.or.kr/service/price/xml.do'
        self.action        = 'periodProductList'
        self.__cert_key    = cert_key
        self.__cert_id     = cert_id
        self.returntype    = 'json'
        self.convert_kg_yn = 'Y'


    async def _get_kamis_data(self, session, params_var):
        params_const = {
            'action'          : self.action,
            'p_cert_key'      : self.__cert_key,
            'p_cert_id'       : self.__cert_id,
            'p_returntype'    : self.returntype,
            'p_convert_kg_yn' : self.convert_kg_yn
        }
        params = dict(params_const, **params_var)
        url = f"{self.url}?{'&'.join(f'{key}={value}' for key, value in params.items())}"
        async with session.get(url) as res:
            if res.status != 200: return None
            content = await res.text()
            content = json.loads(content)
            if   content['data'] == ['200']: raise Exception("Wrong Parameters.")
            elif content['data'] == ['900']: raise Exception("Unauthenticated request.")
            elif content['data'] == ['001']: return None
            else:
                kamis_data = content['data']['item']
        return kamis_data
    

    async def _get_all_kamis_data(self, params_var_list: dict):
        async with aiohttp.ClientSession() as session:
            all_kamis_data = []
            for params_var in params_var_list:
                kamis_data = asyncio.ensure_future(self._get_kamis_data(session, params_var))
                all_kamis_data.append(kamis_data)
            return await asyncio.gather(*all_kamis_data, return_exceptions=True)

    
    @duration
    def get_kamis_data(self, params_var_list: dict):
        """
        kamis api로 요청을 보냅니다.

        필수 params는 다음과 같습니다.
        p_startday, p_endday, p_productclscode, p_itemcode, p_productrankcode

        선택 params는 다음과 같습니다.
        p_itemcategorycode, p_kindcode, p_countrycode, p_convert_kg_yn
        """

        return self.loop.run_until_complete(self._get_all_kamis_data(params_var_list))


if __name__ == "__main__":
    scrap = Scrap()
    print(scrap.get_google_images(['사과', '딸기', '복숭아']))
    # scrap.kamis_setting('1', '1')
    # test_range = list(range(1000, 4000))
    # countries = {'서울': 1101, '부산': 2100, '대구': 2200,
    #              '광주': 2401, '대전': 2501, '인천': 2300,
    #              '울산': 2601, '수원': 3111, '춘천': 3211, 
    #              '청주': 3311, '전주': 3511, '포항': 3711,
    #              '제주': 3911, '순천': 3613, '안동': 3714,
    #              '창원': 3814, '용인': 3145, '의정부': 3113,
    #              '세종': 2701, '강릉': 3214}
    # for country in countries.values():
    #     test_range.remove(country)
    # print(scrap.get_kamis_data([{'p_startday': '2021-10-27', 'p_endday': '2021-10-28', 'p_productclscode': '01', 'p_itemcode': 111, 'p_productrankcode': '04', 'p_countrycode': countrycode} for countrycode in test_range]))
