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
    props: ['pricesList'],
    mounted () {
    },
    computed: {
      datacollection () {
        let datasets = []
        let labels = new Array(300)
        labels.fill('test')
        if (this.pricesList.length > 0) {
          for (let i = 0; i < this.pricesList.length; i++) {
            const prices = this.pricesList[i]
            let data = []
            for (let j = 0; j < prices.length; j++) {
              const price = prices[j]
              data.push(price.price)
            }
            const dataset = {
              label: null,
              borderColor: 'rgba(255,0,0,255)',
              borderWidth: 1,
              radius: 0,
              backgroundColor: 'rgba(0,0,0,0)',
              data: data
            }
            datasets.push(dataset)
          }
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
      }
    },
  }
</script>

<style>
  .small {
    max-width: 600px;
    margin:  150px auto;
  }
</style>