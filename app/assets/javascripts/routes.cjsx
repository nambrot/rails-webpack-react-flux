React = require('react')
Router = require('react-router')

DefaultRoute = Router.DefaultRoute
Route = Router.Route

PostsIndex = require "components/posts/index"
PostShow = require "components/posts/show"
PostNew = require "components/posts/new"
PostEdit = require "components/posts/edit"
routes = (
  <Route name="app" path="/">
    <Route name="posts">
      <Route name="newPost" path="new" handler={PostNew} />
      <Route name="post" path=":postId">
        <Route name="editPost" path="edit" handler={PostEdit} />
        <DefaultRoute handler={PostShow} />
      </Route>
      <DefaultRoute handler={PostsIndex} />
    </Route>
    <DefaultRoute handler={PostsIndex} />
  </Route>
)

module.exports = routes
