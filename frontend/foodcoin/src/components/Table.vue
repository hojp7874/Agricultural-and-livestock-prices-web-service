<template>
  <div>
    <b-table
      :items="foods"
      :fields="fields"
      :sort-by.sync="sortBy"
      :sort-desc.sync="sortDesc"
      striped
      hover
      selectable
      @row-selected="rowSelected"
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
        // { key: 'item_code', sortable: true },
        { key: 'food', sortable: true },
      ],
    }
  },
  props: ['foods'],
  methods: {
    rowSelected (rows) {
      this.$emit('row-selected', rows)
    }
  },
}
</script>

<style>

</style>