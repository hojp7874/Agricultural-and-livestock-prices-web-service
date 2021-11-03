<template>
  <div>
    <Chart/>
    <Table :items="items"/>
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
      items: Object
    }
  },
  methods: {
    get_foods() {
      axios.get(`${SERVER_URL}/prices/food-table/`)
        .then((res) => {
          this.items = res.data
        })
        .catch((err) => {
          console.log(err)
        })
    }
  },
  created() {
    this.get_foods()
  }
}
</script>

<style>

</style>