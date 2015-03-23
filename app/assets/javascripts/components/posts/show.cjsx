React = require('react')
ReactRouter = require("react-router")
FluxComponent = require('flummox/component')

Show = React.createClass
  displayName: "PostShow"
  render: ->
    if @props.post
      <article>
        <header>
          <h3>{@props.post.get('title')}</h3>
        </header>
        <div dangerouslySetInnerHTML={__html: @props.post.get('content')} />
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
