json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year
  json.number do
    json.ofBeers brewery.beers.count
  end
end
