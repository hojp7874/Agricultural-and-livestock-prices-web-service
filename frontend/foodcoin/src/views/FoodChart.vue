<template>
  <div>
    <chart-page/>
    <Table/>
  </div>
</template>

<script>
import ChartPage from '../components/ChartPage.vue'
import Table from '../components/Table.vue'

export default {
  name: 'FoodChart',
  components: {
    Table,
    ChartPage
  }
}
</script>

<style>

</style>