React = require('react')
FluxComponent = require('flummox/component')
Link = require('react-router').Link

Index = React.createClass
  displayName: "PostsIndex"
  render: ->
    <div>
      {
        @props.posts.map (post) ->
          <article key={post.get('id')}>
            <header>
              <h3>
                <Link to="post" params={postId: post.get('id')}>
                  {post.get('title')}
                </Link>
              </h3>
            </header>
          </article>
        .toArray()
      }
    </div>

FluxIndex = React.createClass
  displayName: "WrappedPostsIndex"
  render: ->
    <FluxComponent connectToStores={
      posts: (store) => posts: store.getAllPosts(), didFetchAll: store.didFetchAll()
      }>
      <Index />
    </FluxComponent>


module.exports = FluxIndex
