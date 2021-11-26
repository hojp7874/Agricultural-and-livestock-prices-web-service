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
      @row-selected="getFoodInfo"
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
    getFoodInfo (item) {
      const food_id = item[0]['item_code']
      axios.get(`${SERVER_URL}/prices/foods/${food_id}/`)
        .then(res => {
          const foodDetail = res.data
          this.$emit('get-prices', foodDetail)
        })
    }
  },
  mounted() {

  }
}
</script>

<style>

</style>