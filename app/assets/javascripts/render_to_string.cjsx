React = require('react')
Router = require('react-router')
routes = require('./routes')

Flux = require('flux')
FluxComponent = require('flummox/component')

renderToString = (route, serializedStoreState, callback) ->
  flux = new Flux()
  flux.deserialize(serializedStoreState)

  Router.run routes, route, (Handler, state) ->
    html = React.renderToString(<FluxComponent flux={flux} render={ => <Handler  />}></FluxComponent>)
    embeddedStoreState = "<script>"
    embeddedStoreState += "window.serializedStoreState = " + JSON.stringify(serializedStoreState)
    embeddedStoreState += "</script>"
    callback (html + embeddedStoreState)

module.exports = renderToString
