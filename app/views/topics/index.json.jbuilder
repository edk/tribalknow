json.array!(@topics) do |topic|
  json.extract! topic, 
  json.url topic_url(topic, format: :json)
end
