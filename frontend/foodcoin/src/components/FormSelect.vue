<template>
  <div>
    {{selectedFood.food}}
    <b-form-select v-model="kind" :options="kindOptions" class="mb-3"></b-form-select>
    <b-form-select v-model="rank" :options="rankOptions" class="mb-3"></b-form-select>
    <b-form-select v-model="cls" :options="clsOptions" class="mb-3"></b-form-select>
    <b-form-select v-model="country" :options="countryOptions" class="mb-3"></b-form-select>
    <b-button @click="submit" variant="outline-primary">Button</b-button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      food: this.selectedFood.item_code,
      foodName: this.selectedFood.food,
      kind: '',
      rank: '',
      cls: '01',
      country: '',
      
      kindOptions: [],
      rankOptions: [],
      clsOptions: [
        { value: '01', text: '소매' },
        { value: '02', text: '도매' }
      ],
      countryOptions: []
    }
  },
  props: ['selectedFood', 'countries'],
  watch: {
    kind(newKind) {
      this.setRanks(newKind)
    }
  },
  methods: {
    setKinds() {
      let kindOptions = []
      const kinds = this.selectedFood.kinds
      for (let i = 0; i < kinds.length; i++) {
        const kind = kinds[i];
        kindOptions.push({ value: i, text: kind['kind'], id: kind['id'] })
      }
      this.kindOptions = kindOptions
      this.kind = kindOptions[0]['value']
    },
    setRanks(kind) {
      let rankOptions = []
      const ranks = this.selectedFood.kinds[kind]['product_ranks']
      for (let i = 0; i < ranks.length; i++) {
        const rank = ranks[i];
        rankOptions.push({ value: rank['product_rank_code'], text: rank['product_rank'] })
      }
      this.rankOptions = rankOptions
      this.rank = rankOptions[0]['value']
    },
    setCountries() {
      let countryOptions = []
      for (let i = 0; i < this.countries.length; i++) {
        const country = this.countries[i];
        countryOptions.push({ value: country['country_code'], text: country['country'] })
      }
      this.countryOptions = countryOptions
      this.country = countryOptions[0]['value']
    },
    submit() {
      const condition = {
        'food': this.food,
        'foodName': this.foodName,
        'kind': this.kindOptions[this.kind].id,
        'rank': this.rank,
        'cls': this.cls,
        'country': this.country
      }
      this.$emit('condition', condition)
    }
  },
  mounted() {
    this.setCountries()
    this.setKinds()
  }
}
</script>