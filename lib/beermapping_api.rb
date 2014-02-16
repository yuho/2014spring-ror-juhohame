class BeermappingApi
  def self.places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.locmap(latlng)
    a = "http://dev.virtualearth.net/REST/v1/Imagery/Map/Road/"
    b = "/15?mapSize=400,400"
    bingkey = "Au_Te68hxOr4Sn8xIqAKuGlHJGxky-lga7q9_HIgHR6n_T0d0ahJEiA4Qjvy3vD2"
    return "#{a}#{latlng}#{b}&pp=#{latlng}&key=#{bingkey}"
  end

  def self.location(id)
    url = "http://beermapping.com/webservice/locmap/#{key}/"
    response = HTTParty.get "#{url}#{id}"
    place = response.parsed_response["bmp_locations"]["location"]
    return locmap("#{place["lat"]},#{place["lng"]}")
  end

  def self.key
	File.read(File.expand_path("lib/beerapi.key"))[0..-2]
  end
end
