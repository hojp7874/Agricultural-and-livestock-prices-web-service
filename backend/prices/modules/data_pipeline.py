from bs4 import BeautifulSoup
import requests
from urllib.parse import quote


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