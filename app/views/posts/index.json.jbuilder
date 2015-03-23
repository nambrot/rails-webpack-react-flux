json.array!(@posts) do |post|
  json.extract! post, :id, :title
  json.url post_url(post, format: :json)
end
