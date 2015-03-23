Store = require('flummox').Store
Immutable = require('immutable')

dummyPosts = {"1": Immutable.OrderedMap({id: "1", title: "Title", content: "<b>I'm cool content</b>"})}

getDefaultState = ->
  { posts: Immutable.OrderedMap(dummyPosts), didFetchAll: false }

class PostsStore extends Store
  constructor: (flux) ->
    super()

    postActionIds = flux.getActionIds('posts')
    @state = getDefaultState()
    @flux = flux

  didFetchAll: ->
    @state.didFetchAll
  getAllPosts: ->
    @state.posts

module.exports = PostsStore
