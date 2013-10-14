json.array!(@answers) do |answer|
  json.extract! answer, 
  json.url answer_url(answer, format: :json)
end
