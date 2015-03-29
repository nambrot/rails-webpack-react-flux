json.array!(@posts) do |post|
  json.extract! post, :id, :title, :updated_at
  json.url post_url(post, format: :json)
end
