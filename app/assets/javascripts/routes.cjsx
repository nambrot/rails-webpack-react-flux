React = require('react')
Router = require('react-router')

DefaultRoute = Router.DefaultRoute
Route = Router.Route

PostsIndex = require "components/posts/index"
PostShow = require "components/posts/show"

routes = (
  <Route name="app" path="/">
    <Route name="posts">
      <Route name="post" path=":postId">
        <DefaultRoute handler={PostShow} />
      </Route>
      <DefaultRoute handler={PostsIndex} />
    </Route>
    <DefaultRoute handler={PostsIndex} />
  </Route>
)

module.exports = routes
