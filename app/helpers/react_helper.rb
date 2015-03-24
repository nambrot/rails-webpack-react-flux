module ReactHelper
  def renderSerializedStoreState(state)
    component = HTTParty.post "http://localhost:3001", body: {path: request.path, serializedStoreState: state.to_json}.to_json, headers: {'Content-Type' => "application/json"}
    component.html_safe
  end
end
