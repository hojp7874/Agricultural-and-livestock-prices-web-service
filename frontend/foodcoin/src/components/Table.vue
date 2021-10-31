<template>
  <div>
    <b-table striped hover :items="items"></b-table>
  </div>
</template>

<script>
export default {
  name: 'Table',
  data: function() {
    return {
      foods: this.items
    }
  },
  props: ['items']
}
</script>

<style>

</style>