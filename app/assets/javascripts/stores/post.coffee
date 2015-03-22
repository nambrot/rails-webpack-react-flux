Store = require('flummox').Store
Immutable = require('immutable')

getDefaultState = ->
  { posts: Immutable.OrderedMap(), didFetchAll: false }

class PostsStore extends Store
  constructor: (flux) ->
    super()

    postActionIds = flux.getActionIds('posts')
    @state = getDefaultState()
    @flux = flux

module.exports = PostsStore
