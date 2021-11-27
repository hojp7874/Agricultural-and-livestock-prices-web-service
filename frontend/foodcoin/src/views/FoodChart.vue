<template>
  <div>
    <Chart :pricesList="pricesList"/>
    <Table :items="items" v-on:get-prices="getPrices"/>
  </div>
</template>

<script>
import Chart from '../components/Chart.vue'
import Table from '../components/Table.vue'
import axios from 'axios'

const SERVER_URL = process.env.VUE_APP_SERVER_URL

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
      pricesList: [],
      foods: [],
    }
  },
  watch: {
    foods(newFoods) {
      if (newFoods.length > 0) {
        const pricesList = []
        for (let i = 0; i < newFoods.length; i++) {
          const food = newFoods[i];
          axios.get(`${SERVER_URL}/prices/foods/${food.item_code}/prices/`, {
            params: {
              kind: food.kinds[0]['id']}
          })
          .then(res => {
            pricesList.push(res.data)
          })
        }
        this.pricesList = pricesList
      } else {
        this.pricesList = []
      }
    }
  },
  methods: {
    getFoods() {
      axios.get(`${SERVER_URL}/prices/food-table/`)
        .then((res) => {
          this.items = res.data
        })
    },
    getPrices (foods) {
      this.foods = foods
    },
  },
  created() {
    this.getFoods()
  }
}
</script>

<style>

</style>