React = require('react')
Router = require('react-router')
routes = require('routes')
Flux = require('flux')
FluxComponent = require('flummox/component')

flux = new Flux()
Router.run routes, Router.HistoryLocation, (Handler, state) ->
  handler = <FluxComponent flux={flux} render={ => <Handler  />}></FluxComponent>
  React.render(handler, document.getElementById("reactContent"))
