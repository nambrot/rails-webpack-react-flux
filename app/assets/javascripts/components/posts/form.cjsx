React = require('react')
Router = require('react-router')

Form = React.createClass
  displayName: "postForm"
  getDefaultProps: ->
    title: ""
    content: ""
  getInitialState: ->
    if @props.post
      @props.post.toJS()
    else
      @constructor.getDefaultProps()

  componentWillReceiveProps: (nextProps) ->
    if @state.title == "" and @state.content == "" and nextProps.post
      @setState nextProps.post.toJS()

  formPath: ->
    if @props.post
      @context.router.makePath("post", postId: @props.post.get('id'))
    else
      @context.router.makePath("posts")
  formSubmitButtonValue: ->
    if @props.post then "Update Post" else "Create Post"

  onTitleChange: (evt) ->
    @setState title: evt.target.value
  onContentChange: (evt) ->
    @setState content: evt.target.value
  onSubmit: (evt) ->
    evt.preventDefault()
    if @props.post
      @props.flux.getActions('posts').updatePost(@state)
      @context.router.transitionTo 'post', postId: @state.id
    else
      @props.flux.getActions('posts').createPost(@state)
      .then (post) => @context.router.transitionTo 'post', postId: post.id

  render: ->
    <form action={@formPath()} method='post' onSubmit={@onSubmit}>
      { <input type="hidden" name="_method" value="PUT" /> if @props.post }

      <label htmlFor="post[title]">Title</label>
      <input name="post[title]" type="text" value={@state.title} onChange={@onTitleChange} />

      <label htmlFor="post[content]">Title</label>
      <textarea name="post[content]" value={@state.content} onChange={@onContentChange} />

      <input type="submit" value={@formSubmitButtonValue()} />
    </form>

Form.contextTypes =
  router: React.PropTypes.func.isRequired

module.exports = Form
