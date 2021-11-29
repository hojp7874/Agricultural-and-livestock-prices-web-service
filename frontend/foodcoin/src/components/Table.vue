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
    methods: {
      getFoodInfo (items) {
        this.$emit('row-selected', items)
      }
    },
    mounted() {

    }
  }
</script>

<style>

</style>