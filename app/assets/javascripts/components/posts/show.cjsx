React = require('react')
ReactRouter = require("react-router")
FluxComponent = require('flummox/component')
Link = ReactRouter.Link

Show = React.createClass
  displayName: "PostShow"
  render: ->
    if @props.post and @props.post.get('content')
      <article>
        <header>
          <h3>
            <Link to="post" params={postId: @props.post.get('id')}>
              {@props.post.get('title')}
            </Link>
          </h3>
        </header>
        <div dangerouslySetInnerHTML={__html: @props.post.get('content')} />
        <br />
        <Link to="editPost" params={postId: @props.post.get('id')}>Edit</Link>
      </article>
    else
      <div>
        <h3>Loading ...</h3>
      </div>


FluxShow = React.createClass
  displayName: "WrappedShow"
  render: ->
    <FluxComponent connectToStores={{
      posts: (store) => post: store.getPost(@context.router.getCurrentParams().postId)
      }}>
      <Show />
    </FluxComponent>

FluxShow.contextTypes =
  router: React.PropTypes.func.isRequired


module.exports = FluxShow
