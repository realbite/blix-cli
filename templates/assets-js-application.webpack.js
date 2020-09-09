// this is the starting point for your application webpack bundle

{% if vue  -%}

{% raw %}

import Vue from 'vue/dist/vue.common.js'
import App from './components/app.vue'

new Vue({
  el: '#app',
  template:'<h1>{{ message }}</h1>',
  data: {
   message: 'Welcome to Blix Vue Application!'
  }
})

{% endraw %}
{% endif %}
