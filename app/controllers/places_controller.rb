class PlacesController < ApplicationController
  def index
  end

  def search
	key = File.read("/home/yuho/rails/ratebeer/lib/beerapi.key")[0..-2]
	url = "http://beermapping.com/webservice/loccity/#{key}/"
	response = HTTParty.get("#{url}#{ERB::Util.url_encode(params[:city])}")
	places = response.parsed_response["bmp_locations"]["location"]

	if places.is_a?(Hash) and places['id'].nil?
		redirect_to places_path, :notice => "No places in #{params[:city]}"
	else
		places = [places] if places.is_a?(Hash)
		@places = places.inject([]) do | set, location |
			set << Place.new(location)
		end
	end

    render :index
  end
end

