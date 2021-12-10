<template>
  <div>
    <b-table
      :items="tableRows"
      :fields="fields"
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
        // { key: 'item_code', sortable: true },
        { key: 'food',      sortable: true },
      ],
    }
  },
  props: ['tableRows'],
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