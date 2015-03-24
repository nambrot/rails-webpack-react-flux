var renderToString = require('enhanced-require')(module, {
  resolve: {
    extensions: ['', '.js', '.jsx', '.cjsx', '.coffee'],
    modulesDirectories: ["node_modules", "javascripts"]
  },

  module: {
    loaders: [
      { test: /\.js?$/, loaders: []},
      { test: /\.jsx?$/, loaders: ['jsx-loader'] },
      { test: /\.cjsx$/, loaders: ["react-hot", "coffee", "cjsx"]},
      { test: /\.coffee$/, loader: "coffee"},
      { test: /\.json$/, loader: "json-loader"}
      ]
  }
})('render_to_string')

var express = require('express')
var app = express()

app.use(require("body-parser").json());
app.post('/', function (req, res) {
  renderToString(req.body.path, req.body.serializedStoreState, function(s){
    res.end(s)
  });
})

var server = app.listen(3001)
