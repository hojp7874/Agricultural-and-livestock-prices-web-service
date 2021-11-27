<template>
  <div>
    <div>
      button
    </div>
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

const SERVER_URL = process.env.VUE_APP_SERVER_URL

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
      pricesConditionsListCache: [],
    }
  },
  props: ['items'],
  computed: {
  //   food_table() {
  //     return this.items
  //   }
  },
  methods: {
    getFoodInfo (items) {
      const pricesConditionsListCache = []
      if (items.length > 0) {
        const foods = []
        for (let i = 0; i < items.length; i++) {
          const item = items[i];
          axios.get(`${SERVER_URL}/prices/foods/${item['item_code']}/prices-conditions/`)
            .then(res => {
              pricesConditionsListCache.push(res.data)
              axios.get(`${SERVER_URL}/prices/foods/${item['item_code']}/`, res.data[0])
                .then(res => {
                  foods.push(res.data)
                })
            })
        }
        this.pricesConditionsListCache = pricesConditionsListCache
        this.$emit('get-prices', foods)
      }
    }
  },
  mounted() {

  }
}
</script>

<style>

</style>