json.array!(@vehicles) do |vehicle|
  json.extract! vehicle, :make, :kind, :year, :color
  json.url vehicle_url(vehicle, format: :json)
end
