<template>
  <div>
    <Chart :pricesList="pricesList"/>
    <Table :items="items" v-on:row-selected="rowSelected"/>
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
      pricesConditionsList: [],
      pricesConditionList: Array({
        food: Number,
        kind: String,
        country: Number,
        productRank: String,
        productCls: String,
        period: 'W', // W: week, M: month, Y: year, T: total
      }),
      pricesList: [],
      foods: [],
    }
  },
  watch: {
    pricesConditionList(newConditionList) {
      if (newConditionList != null) {
        const pricesList = []
        for (let i = 0; i < newConditionList.length; i++) {
          const newCondition = newConditionList[i];
          axios.get(`${SERVER_URL}/prices/foods/${newCondition.food}/prices/`, {params: {'condition': newCondition}})
            .then(res => {
              pricesList.push(res.data)
            })
        this.pricesList = pricesList
        }
      } else {
        this.pricesList = []
      }
    }
  },
  methods: {
    rowSelected(rows) {
      const foodIds = rows.map(x => x['item_code'])
      this.setPricesConditions(foodIds)
      this.getFoodDetail(foodIds)
    },
    setPricesConditions(foodIds) {
      if (foodIds.length > 0) {
        const pricesConditionsList = []
        const pricesConditionList = []
        for (let i = 0; i < foodIds.length; i++) {
          const foodId = foodIds[i];
          axios.get(`${SERVER_URL}/prices/foods/${foodId}/prices-conditions/`)
            .then(res => {
              pricesConditionsList.push(res.data)
              pricesConditionList.push(res.data[0])
            })
        }
        this.pricesConditionsList = pricesConditionsList
        this.pricesConditionList = pricesConditionList
      } else {
        this.pricesConditionsList = null
        this.pricesConditionList = null
      }
      // console.log(this.pricesConditionsList)
      // console.log(this.pricesConditionList)
    },
    getTable() {
      axios.get(`${SERVER_URL}/prices/food-table/`)
        .then((res) => {
          this.items = res.data
        })
    },
    getFoodDetail(foodIds) {
      for (let i = 0; i < foodIds.length; i++) {
        const foodId = foodIds[i];
        axios.get(`${SERVER_URL}/prices/foods/${foodId}/`)
          .then((res) => {
            console.log(res)
          })
      }
    },
    getPrices (foods) {
      this.foods = foods
    },
  },
  created() {
    this.getTable()
  }
}
</script>

<style>

</style>