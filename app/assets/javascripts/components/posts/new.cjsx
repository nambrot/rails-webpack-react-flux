React = require('react')
Router = require('react-router')
PostForm = require('./form')
FluxComponent = require('flummox/component')

New = React.createClass
  displayName: 'PostNew'
  render: ->
    <article>
      <h1>New Post</h1>
      <FluxComponent>
        <PostForm />
      </FluxComponent>
    </article>


module.exports = New
