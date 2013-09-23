json.array!(@companies) do |company|
  json.extract! company, :name, :location
  json.url company_url(company, format: :json)
end
