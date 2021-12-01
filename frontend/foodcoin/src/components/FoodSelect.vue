<template>
  <div>
    <div>
      {{condition.food}}
      Food
      <FormSelect :condition="condition"/>
      Kind
      <FormSelect :condition="condition"/>
      Rank
      <FormSelect :condition="condition"/>
      Cls
      <FormSelect :condition="condition"/>
      Country
      <FormSelect :condition="condition"/>
    </div>
  </div>
</template>

<script>
import FormSelect from './FormSelect'

export default {
  components: {
    FormSelect
  },
  data() {
    return {
      options: [
        { value: 'A', text: 'Option A (from options prop)' },
        { value: 'B', text: 'Option B (from options prop)' }
      ]
    }
  },
  props: ['condition']
}
</script>