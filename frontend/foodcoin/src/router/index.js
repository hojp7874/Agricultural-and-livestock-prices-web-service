import Vue from 'vue'
import VueRouter from 'vue-router'
import FoodChart from '../views/FoodChart.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '',
    name: 'FoodChart',
    component: FoodChart
  }
]

const router = new VueRouter({
  routes
})

export default router
