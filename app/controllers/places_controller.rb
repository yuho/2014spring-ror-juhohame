class PlacesController < ApplicationController
  def index
  end

	def search
		@places = BeermappingApi.places_in(params[:city])
		if @places.empty?
			redirect_to places_path, notice: "No locations in #{params[:city]}"
		else
			render :index
		end
	end

	def show
		@places = BeermappingApi.places_in(params[:city])
		@place = @places.find { |p| p.id = params[:id] }
		@mapurl = BeermappingApi.location(params[:id])
	end

end

