<template>
  <div id="app">
    <div id="nav">
      <div>
        <b-navbar toggleable="sm" type="light" variant="light">
          <b-navbar-toggle target="nav-text-collapse"></b-navbar-toggle>
          <b-navbar-brand class="mx-3">Food Coin</b-navbar-brand>
          <b-collapse id="nav-text-collapse" is-nav>
            <b-navbar-nav>
              <router-link to="/" class="mx-2">Home</router-link>
              <router-link to="/food-chart" class="mx-2">FoodChart</router-link>
              <router-link to="/about" class="mx-2">About</router-link>
            </b-navbar-nav>
          </b-collapse>
        </b-navbar>
      </div>
    </div>
    <router-view/>
  </div>
</template>

<script>

export default {
  name: 'App',
  components: {
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

/* #nav {
  padding: 30px;
} */

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>
