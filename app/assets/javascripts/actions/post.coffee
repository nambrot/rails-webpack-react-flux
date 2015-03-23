Actions = require('flummox').Actions
axios = require('axios')
class PostActions extends Actions
  fetchAllPosts: ->
    axios.get('/posts', headers: {'Accept': 'application/json'})
    .then (posts) -> posts.data

module.exports = PostActions
