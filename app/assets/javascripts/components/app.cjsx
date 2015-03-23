React = require('react')
Router = require('react-router')
RouteHandler = Router.RouteHandler
Link = Router.Link
FluxComponent = require('flummox/component')

App = React.createClass
  displayName: "App"
  render: ->
    <div id="main">
      <header>
        <h2><Link to="posts">Super Cool Blog</Link></h2>
      </header>
      <div id="reactContent">
        <FluxComponent>
          <RouteHandler/>
        </FluxComponent>
      </div>

    </div>

module.exports = App
