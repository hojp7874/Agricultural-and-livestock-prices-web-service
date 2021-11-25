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
        datacollection: Object,
      }
    },
    mounted () {
      this.fillData()
    },
    methods: {
      fillData () {
        const data1 = [];
        const data2 = [];
        const labels = [];
        let prev1 = 100;
        let prev2 = 80;
        for (let i = 0; i < 1000; i++) {
          labels.push(i)
          prev1 += 5 - Math.random() * 10;
          data1.push({x: i, y: prev1});
          prev2 += 5 - Math.random() * 10;
          data2.push({x: i, y: prev2});
        }
        this.datacollection = {
          labels: labels,
          datasets: [
            {
              label: 'Data One',
              backgroundColor: '#f87979',
              data: data1
            }, {
              label: 'Data One',
              backgroundColor: '#f87979',
              data: data2
            }
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