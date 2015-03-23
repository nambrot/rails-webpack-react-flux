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
    @registerAsync postActionIds.fetchPost, @startFetchingPost, @fetchedPost
    @state = getDefaultState()
    @flux = flux

  startFetchingPosts: (posts) ->
    # Maybe in reality show some loading indicator
  startFetchingPost: (post) ->

  fetchedAllPosts: (posts) ->
    # merge the incoming data with potentially already existent data. Practically, you'd want to do more intelligent merge conflict resolution
    @setState posts: getPostsFromJSON(posts).merge(@state.posts), didFetchAll: true
  fetchedPost: (post) ->
    @setState posts: @state.posts.set("#{post.id}", Immutable.OrderedMap(post))

  didFetchAll: ->
    @state.didFetchAll
  getAllPosts: ->
    @flux.getActions('posts').fetchAllPosts() unless @state.didFetchAll
    @state.posts
  getPost: (id) ->
    post = @state.posts.get("#{id}")
    @flux.getActions('posts').fetchPost(id) unless post and post.get('content')
    post

module.exports = PostsStore
