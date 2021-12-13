<template>
  <div>
    <b-container class="d-flex justify-content-between">
      <b-col cols=9>
        <Chart :pricesDict="pricesDict"/>
        <b-badge
          @click="deleteRow(key)"
          style="background-color: #5555ff; cursor:pointer"
          class="mx-1"
          v-for="prices, key in pricesDict"
          :key="key"
        >
          {{ key }}
        </b-badge>
        <FormSelect 
          @condition="getPrices" 
          :countries="countries" 
          :selectedFood="selectedFood" 
          v-for="selectedFood in selectedFoods" 
          :key="selectedFood.item_code"
        />
      </b-col>
      <b-col>
        <Table :foods="foods" @row-selected="rowSelect"/>
      </b-col>
    </b-container>
  </div>
</template>

<script>
import Chart from '../components/Chart.vue'
import Table from '../components/Table.vue'
import FormSelect from '../components/FormSelect.vue'
import axios from 'axios'

const SERVER_URL = process.env.VUE_APP_SERVER_URL

export default {
  name: 'FormChart',
  components: {
    Table,
    Chart,
    FormSelect,
  },
  data() {
    return {
      foods: [],
      pricesDict: {},
      selectedFoods: [],
      countries: []
    }
  },
  methods: {
    deleteRow (row) {
      let newPricesDict = Object.assign({}, this.pricesDict)
      delete newPricesDict[row]
      this.pricesDict = newPricesDict
    },
    rowSelect(rows) {
      const foodIds = rows.map(x => x['item_code'])
      this.getFoodDetail(foodIds)
    },
    getTable() {
      axios.get(`${SERVER_URL}/prices/food-table/`)
        .then((res) => {
          this.foods = res.data
        })
    },
    getFoodDetail(foodIds) {
      let selectedFoods = []
      for (let i = 0; i < foodIds.length; i++) {
        const foodId = foodIds[i];
        axios.get(`${SERVER_URL}/prices/foods/${foodId}/`)
          .then((res) => {
            selectedFoods.push(res.data)
          })
      }
      this.selectedFoods = selectedFoods
    },
    getCountries() {
      axios.get(`${SERVER_URL}/prices/countries/`)
        .then((res) => {
          this.countries = res.data
        })
    },
    getPrices(condition) {
      let pricesDict = {}
      const foodId = condition.food
      const foodName = condition.foodName
      const params = {
        // 'food_id': condition.food,
        'kind_id': condition.kind,
        'product_rank_id': condition.rank,
        'product_cls_id': condition.cls,
        'country_id': condition.country
      }
      axios.get(`${SERVER_URL}/prices/foods/${foodId}/prices/`, {params: {'condition': params}})
        .then(res => {
          if (res.data.length == 0) {
            window.alert(`해당 조건에 맞는 '${condition.foodName}' 데이터가 없습니다.`)
            return
          }
          for (const [key, prices] of Object.entries(this.pricesDict)) {
            pricesDict[key] = prices
          }
          pricesDict[foodName] = res.data
          this.pricesDict = pricesDict
        })
    }
  },
  created() {
    this.getTable()
    this.getCountries()
  }
}
</script>

<style>

</style>