<template>
  <div class="small">
    <line-chart :chart-data="datacollection"></line-chart>
    <button @click="fillData()">Randomize</button>
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
        datacollection: {},
      }
    },
    props: ['prices'],
    mounted () {
      this.fillData()
    },
    methods: {
      fillData () {
        const data1 = [];
        const labels = [];
        for (let i = 0; i < this.prices.length; i++) {
          const price = this.prices[i]
          labels.push(price.date)
          data1.push(price.price)
        }
        this.datacollection = {
          labels: labels,
          datasets: [
            {
              label: null,
              borderColor: 'rgba(255,0,0,255)',
              borderWidth: 1,
              radius: 0,
              backgroundColor: 'rgba(0,0,0,0)',
              data: data1
            },// {
            //   // label: 'Data One',
            //   borderColor: 'rgba(0,0,255,255)',
            //   borderWidth: 1,
            //   radius: 0,
            //   backgroundColor: 'rgba(0,0,0,0)',
            //   data: data2
            // }
          ]
        }
      },
      getRandomInt () {
        return Math.floor(Math.random() * (50 - 5 + 1)) + 5
      }
    }
  }
</script>

<style>
  .small {
    max-width: 600px;
    margin:  150px auto;
  }
</style>