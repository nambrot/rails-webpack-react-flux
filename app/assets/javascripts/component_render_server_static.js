var renderToString = require('render_to_string')
var express = require('express')
var bodyParser = require("body-parser/lib/types/json")

var app = express()

app.use(bodyParser);
app.post('/', function (req, res) {
  renderToString(req.body.path, req.body.serializedStoreState, function(s){
    res.end(s)
  });
})

var server = app.listen(3001)
