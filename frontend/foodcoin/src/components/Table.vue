<template>
  <div>
      <!-- :fields="fields" -->
    <b-table
      :items="items"
      :sort-by.sync="sortBy"
      :sort-desc.sync="sortDesc"
      striped
      hover
      selectable
      @row-selected="get_food_detail"
    ></b-table>
  </div>
</template>

<script>
import axios from 'axios'

const SERVER_URL = process.env.VUE_APP_SERVER_URL_LOCAL

export default {
  name: 'Table',
  data() {
    return {
      sortBy: 'item_code',
      sortDesc: false,
      fields: [
        { key: 'item_code', sortable: true },
        { key: 'food',      sortable: true },
        { key: 'kind',      sortable: true },
        { key: 'price',     sortable: true },
      ],
    }
  },
  props: ['items'],
  // computed: {
  //   food_table() {
  //     return this.items
  //   }
  // },
  methods: {
    get_prices (item) {
      const food_id = item[0]['item_code']
      axios.get(`${SERVER_URL}/prices/foods/${food_id}/prices/`)
        .then(res => {
          console.log(res)
        })
    },
    get_food_detail (item) {
      const food_id = item[0]['item_code']
      axios.get(`${SERVER_URL}/prices/foods/${food_id}/`)
        .then(res => {
          console.log(res)
        })
    }
  },
  mounted() {

  }
}
</script>

<style>

</style>