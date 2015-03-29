var webpack = require('webpack');
var path = require("path");

module.exports = {

  // Should be /app/assets
  context: __dirname,

  entry: {
    app: [
      'webpack-dev-server/client?http://localhost:8080/assets/',
      'webpack/hot/only-dev-server',
      './javascripts/client_application.cjsx'
    ],
    server: [
      './javascripts/component_render_server_static.js'
    ]
  },

  // This will cause webpack to compile it to /app/assets/javascripts/app.js, or if you use the Webpack Dev Server be available as http://localhost:8080/assets/javascripts/app.js
  output: {
    filename: '[name].js', // Will output
    path: __dirname + "/javascripts",
    publicPath: 'http://localhost:8080/assets/javascripts'
  },

  // Require the webpack
  plugins: [
    new webpack.NoErrorsPlugin()
  ],

  resolve: {
    extensions: ['', '.js', '.jsx', '.cjsx', '.coffee'],
    modulesDirectories: ["node_modules", "javascripts"]
  },

  module: {
    loaders: [
      { test: /\.js?$/, loaders: ['react-hot']},
      { test: /\.jsx?$/, loaders: ['react-hot', 'jsx-loader'] },
      { test: /\.cjsx$/, loaders: ["react-hot", "coffee", "cjsx"]},
      { test: /\.coffee$/, loader: "coffee"},
      { test: /\.json$/, loader: "json-loader"}
      ]
  },

  node: {
    net: "empty",
    fs: "empty"
  }


};
