<template>
  <div>
    <Chart :prices="prices"/>
    <Table :items="items" v-on:get-prices="getPrices"/>
  </div>
</template>

<script>
import Chart from '../components/Chart.vue'
import Table from '../components/Table.vue'
import axios from 'axios'

const SERVER_URL = process.env.VUE_APP_SERVER_URL_LOCAL

export default {
  name: 'FoodChart',
  components: {
    Table,
    Chart
  },
  data() {
    return {
      items: Object,
      pricesCondition: {
        food: Number,
        kind: String,
        country: Number,
        productRank: String,
        productCls: String,
        period: 'W', // W: week, M: month, Y: year, T: total
      },
      searchConditions: [],
      prices: Array,
    }
  },
  methods: {
    getFoods() {
      axios.get(`${SERVER_URL}/prices/food-table/`)
        .then((res) => {
          this.items = res.data
        })
        .catch((err) => {
          console.log(err)
        })
    },
    getPrices (food) {
      axios.get(`${SERVER_URL}/prices/foods/${food.item_code}/prices/`, {
        params: {
          kind: food.kinds[0]['id']}
        })
        .then(res => {
          this.prices = res.data
          console.log(this.prices)
        })
    },
  },
  created() {
    this.getFoods()
  }
}
</script>

<style>

</style>