const path = require('path');

{% if vue  -%}
const VueLoaderPlugin = require('vue-loader/lib/plugin');
{% endif %}

module.exports = {
  module: {
    rules: [
      {
        test: /\.coffee$/,
        loader: 'coffee-loader',
      },
      {% if vue  -%}
      {
        test: /\.vue$/,
        loader: 'vue-loader'
      },
      {
        test: /\.css$/,
        use: [
          'vue-style-loader',
          'css-loader'
        ]
      },
      {
        test: /\.scss$/,
        use: [
          'vue-style-loader',
          'css-loader',
          'sass-loader'
        ]
      },
      {% endif %}
    ],
  },
  {% if vue  -%}
  plugins: [
    new VueLoaderPlugin()
  ]
  {% endif %}

};
