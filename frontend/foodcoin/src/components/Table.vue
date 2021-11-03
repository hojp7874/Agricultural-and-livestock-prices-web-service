<template>
  <div @click="get_prices">
    <b-table striped hover :items="food_table" @click="get_prices(food_id)"></b-table>
  </div>
</template>

<script>
import axios from 'axios'

const SERVER_URL = process.env.VUE_APP_SERVER_URL_LOCAL

export default {
  name: 'Table',
  data: function() {
    return {
    }
  },
  props: ['items'],
  computed: {
    food_table() {
      return this.items
    }
  },
  methods: {
    get_prices(food_id) {
      axios.get(`${SERVER_URL}/prices/foods/${food_id}/prices`)
      
    }
  },
  mounted() {

  }
}
</script>

<style>

</style>