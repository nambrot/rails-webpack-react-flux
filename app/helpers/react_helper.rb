module ReactHelper
  def renderSerializedStoreState(state)
    component = "<script>"
    component += "window.serializedStoreState = " + state.to_json.to_json
    component += "</script>"
    component.html_safe
  end
end
