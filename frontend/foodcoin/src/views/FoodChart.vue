<template>
  <div>
    <Chart :pricesDict="pricesDict"/>
    <FormSelect 
      @condition="getPrices" 
      :countries="countries" 
      :selectedFood="selectedFood" 
      v-for="selectedFood in selectedFoods" 
      :key="selectedFood.item_code"
    />
    <Table :tableRows="tableRows" @row-selected="rowSelected"/>
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
      tableRows: Object,
      pricesDict: {},
      selectedFoods: [],
      countries: []
    }
  },
  methods: {
    rowSelected(rows) {
      const foodIds = rows.map(x => x['item_code'])
      this.getFoodDetail(foodIds)
    },
    getTable() {
      axios.get(`${SERVER_URL}/prices/food-table/`)
        .then((res) => {
          this.tableRows = res.data
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
        'food_id': condition.food,
        'kind_id': condition.kind,
        'product_rank_id': condition.rank,
        'product_cls_id': condition.cls,
        'country_id': condition.country
      }
      axios.get(`${SERVER_URL}/prices/foods/${foodId}/prices/`, {params: {'condition': params}})
        .then(res => {
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