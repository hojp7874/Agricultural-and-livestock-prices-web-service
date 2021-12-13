<template>
  <div class="small">
    <line-chart :chart-data="datacollection"></line-chart>
    <!-- <b-badge
      @click="deleteRow(key)"
      style="background-color: black; cursor:pointer"
      v-for="prices, key in pricesDict"
      :key="key"
    >
      {{ key }}
    </b-badge> -->
  </div>
</template>

<script>
import LineChart from './LineChart.js'

export default {
  components: {
    LineChart
  },
  data () {
    return {
    }
  },
  props: ['pricesDict'],
  mounted () {
  },
  computed: {
    datacollection () {
      // if(Object.keys(this.pricesDict).length == 0) {
      //   return {
      //     labels: null,
      //     datasets: null
      //   }
      // }
      let datasets = []
      let labels = []
      for (const [key, prices] of Object.entries(this.pricesDict)) {
        let color = "#" + Math.round(Math.random() * 0xffffff).toString(16)
        let data = []
        labels = []
        for (let j = 0; j < prices.length; j++) {
          const price = prices[j]
          data.push(price.price)
          labels.push(price.date)
        }
        const dataset = {
          label: key,
          borderColor: color,
          borderWidth: 1,
          radius: 0,
          backgroundColor: 'rgba(0,0,0,0)',
          data: data
        }
        datasets.push(dataset)
      }
      const result = {
        labels: labels,
        datasets: datasets
      }
      return result
    }
  },
  methods: {
    getRandomInt () {
      return Math.floor(Math.random() * (50 - 5 + 1)) + 5
    },
  },
}
</script>

<style>
  .small {
    max-width: 600px;
    margin:  150px auto;
  }
</style>