Flummox = require('flummox').Flummox
PostsStore = require('stores/post')
PostActions = require('actions/post')

class AppFlux extends Flummox
  constructor: ->
    super()
    @createActions 'posts', PostActions
    @createStore 'posts', PostsStore, this

module.exports = AppFlux
