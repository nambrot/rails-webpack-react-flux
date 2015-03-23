Actions = require('flummox').Actions
axios = require('axios')

acceptJSON = {'Accept': 'application/json'}

class PostActions extends Actions
  fetchAllPosts: ->
    axios.get('/posts', headers: acceptJSON)
    .then (posts) -> posts.data
  fetchPost: (id) ->
    axios.get("/posts/#{id}", headers: acceptJSON)
    .then (response) -> response.data

module.exports = PostActions
