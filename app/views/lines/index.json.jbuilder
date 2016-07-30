json.array!(@lines) do |line|
  json.extract! line, :id, :number
  json.url line_url(line, format: :json)
end
