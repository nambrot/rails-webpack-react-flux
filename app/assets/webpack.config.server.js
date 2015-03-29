var webpack = require('webpack');
var path = require("path");

module.exports = {

  // Should be /app/assets
  context: __dirname,

  entry: {
    server: [
      './javascripts/component_render_server_static.js'
    ]
  },

  output: {
    filename: 'server.js', // Will output
    path: __dirname + "/javascripts",
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
      { test: /\.jsx?$/, loaders: ['jsx-loader'] },
      { test: /\.cjsx$/, loaders: ["coffee", "cjsx"]},
      { test: /\.coffee$/, loader: "coffee"},
      { test: /\.json$/, loader: "json-loader"}
      ]
  },

  node: {
    net: "empty",
    fs: "empty",
    http: "empty"
  }


};
