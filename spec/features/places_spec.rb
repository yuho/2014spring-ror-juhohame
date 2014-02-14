require 'spec_helper'
require 'webmock/rspec'

describe "Places" do
	it "if none is returned by the API, \"no locations\" is shown on the page" do
		BeermappingApi.stub(:places_in).with("kumpula").and_return(Array.new())
		visit places_path
		searchfor = "kumpula"
		fill_in("city", with: searchfor)
		click_button "Search"
		expect(page).to have_content("No locations in #{searchfor} city")
	end

	it "if one is returned by the API, it is shown on the page" do
		BeermappingApi.stub(:places_in).with("kumpula").and_return(
			[ Place.new(:name => "Oljenkorsi") ]
		)

		visit places_path
		fill_in("city", with: "kumpula")
		click_button "Search"

		expect(page).to have_content "Oljenkorsi"
	end

	it "if two is returned by the API, both are shown on the page" do
		names = ["Hello","World"]
		places = Array.new()
		names.each { |n| places.push(Place.new(:name => n)) }

		BeermappingApi.stub(:places_in).with("kumpula").and_return(
			places
		)

		visit places_path
		fill_in("city", with: "kumpula")
		click_button "Search"

		names.each { |n| expect(page).to have_content(n) }
	end
end
