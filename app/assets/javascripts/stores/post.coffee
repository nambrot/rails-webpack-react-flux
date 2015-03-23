Store = require('flummox').Store
Immutable = require('immutable')

getDefaultState = ->
  { posts: Immutable.OrderedMap(), didFetchAll: false }
getPostsFromJSON = (posts) ->
  immutablePosts = {}
  immutablePosts["#{post.id}"] = Immutable.OrderedMap(post) for post in posts
  Immutable.OrderedMap(immutablePosts)

class PostsStore extends Store
  constructor: (flux) ->
    super()

    postActionIds = flux.getActionIds('posts')
    @registerAsync postActionIds.fetchAllPosts, @startFetchingPosts, @fetchedAllPosts
    @state = getDefaultState()
    @flux = flux

  startFetchingPosts: (posts) ->
    # Maybe in reality show some loading indicator

  fetchedAllPosts: (posts) ->
    @setState posts: getPostsFromJSON(posts), didFetchAll: true

  didFetchAll: ->
    @state.didFetchAll
  getAllPosts: ->
    @flux.getActions('posts').fetchAllPosts() unless @state.didFetchAll
    @state.posts

module.exports = PostsStore
