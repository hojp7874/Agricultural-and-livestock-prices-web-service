<template>
  <div>
    <chart-page/>
    <Table :items="items"/>
  </div>
</template>

<script>
import ChartPage from '../components/ChartPage.vue'
import Table from '../components/Table.vue'
import axios from 'axios'

const SERVER_URL = process.env.VUE_APP_SERVER_URL_LOCAL

export default {
  name: 'FoodChart',
  components: {
    Table,
    ChartPage
  },
  data: function() {
    return {
      items: Object
    }
  },
  // computed: {
  //   foods: function() {
  //     return 
  //   }
  // },
  methods: {
    get_foods: function() {
      axios.get(`${SERVER_URL}/prices/foods/`)
        .then((res) => {
          console.log(res)
          this.items = res.data
          console.log(this.items)
        })
        .catch((err) => {
          console.log(err)
        })
      return 'test'
    }
  },
  created: function() {
    this.get_foods()
  }
}
</script>

<style>

</style>