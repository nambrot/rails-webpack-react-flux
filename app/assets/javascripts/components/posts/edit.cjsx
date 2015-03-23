FluxComponent = require 'flummox/component'
Form = require './form'
React = require 'react'

Edit = React.createClass
  displayName: "PostEdit"
  render: ->
    <article>
      <h1>Edit Post</h1>
      <FluxComponent>
        <Form post={@props.post} />
      </FluxComponent>
    </article>

FluxEdit = React.createClass
  displayName: 'FluxEdit'
  render: ->
    <FluxComponent connectToStores={{
      posts: (store) => post: store.getPost(@context.router.getCurrentParams().postId)
      }}>
      <Edit />
    </FluxComponent>

FluxEdit.contextTypes =
  router: React.PropTypes.func.isRequired

module.exports = FluxEdit
