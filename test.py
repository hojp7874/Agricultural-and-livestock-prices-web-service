from urllib.request import urlopen, Request
from urllib.parse import urlencode, quote_plus
import json

#---------
import base64
from io import BytesIO

from flask import Flask, jsonify, request, render_template

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.figure import Figure
import seaborn as sns

app = Flask(__name__)

@app.route("/")
def hello():
    # fig = Figure()
    # ax = fig.subplots()
    # ax.set_ylim(0, 30)
    # suicide = pd.read_csv('master.csv')
    # ax.plot(suicide.groupby('year')['suicides/100k pop'].mean())
    # ax.plot(suicide[suicide.sex == 'male'].groupby('year')['suicides/100k pop'].mean())
    # ax.plot(suicide[suicide.sex == 'female'].groupby('year')['suicides/100k pop'].mean())

    # ax.legend(['Total', 'Male', 'Female'])
    # Save it to a temporary buffer.
    # buf = BytesIO()
    # fig.savefig(buf, format="png")
    # Embed the result in the html output.
    # data = base64.b64encode(buf.getbuffer()).decode("ascii")

    # data_src = f'data:image/png;base64,{data}/'
    # return render_template('index.html', data_src=data_src)

#---------------------    
    url = 'http://apis.data.go.kr/B552895/openapi/service/OrgPriceExaminService/getExaminPriceList'
    with open('secret.json') as jsonfile:
        data = json.load(jsonfile)
        SERVICE_KEY = data["ServiceKey"]
    queryParams = '?' + urlencode({ quote_plus('ServiceKey') : SERVICE_KEY })

    request = Request(url + queryParams)
    request.get_method = lambda: 'GET'
    response_body = urlopen(request).read()
    print(response_body)

    
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)