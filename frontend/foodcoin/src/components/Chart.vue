<template>
  <div class="small">
    <line-chart :chart-data="datacollection"></line-chart>
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
      let datasets = []
      let labels = []
      let minStartDate = new Date()
      for (const prices of Object.values(this.pricesDict)) {
        const startDate = new Date(prices[0].date.split('-').map(Number))
        if (new Date(prices[0].date.split('-').map(Number)) < minStartDate) {
          minStartDate = startDate
        }
      }
      let endDate = new Date()
      let date = minStartDate
      while (date < endDate) {
        labels.push(new Date(date).toDateString())
        date.setDate(date.getDate() + 1)
      }
      for (const [key, prices] of Object.entries(this.pricesDict)) {
        let color = "#" + Math.round(Math.random() * 0xffffff).toString(16)
        let data = []
        let i = 0
        for (let j = 0; j < prices.length; j++) {
          const price = prices[j]
          const date = new Date(prices[j].date.split('-').map(Number))
          while (i < labels.length && date > new Date(labels[i])) {
            data.push(price.price)
            i++
          }
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