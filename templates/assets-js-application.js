{%- if webpack  -%}
//= require application.webpack.js
{%- else -%}
// application javascript here
{%- endif %}
//

{%- if vuebasic %}
{% raw %}


var app = new Vue({
  el: '#app',
  template:'<h1>{{ message }}</h1>',
  data: {
    message: 'Welcome to Basic Blix Vue!'
  }
})

{% endraw %}
{%- endif %}
