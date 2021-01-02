from urllib.request import urlopen, Request
from urllib.parse import urlencode, quote_plus
import json


url = 'http://apis.data.go.kr/B552895/openapi/service/OrgPriceExaminService/getExaminPriceList'
with open('secret.json') as jsonfile:
    data = json.load(jsonfile)
    SERVICE_KEY = data["ServiceKey"]
queryParams = '?' + urlencode({ quote_plus('ServiceKey') : SERVICE_KEY })

request = Request(url + queryParams)
request.get_method = lambda: 'GET'
response_body = urlopen(request).read()
print(response_body)