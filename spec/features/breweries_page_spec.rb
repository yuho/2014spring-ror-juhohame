require 'spec_helper'

describe "Breweries page" do

	it "should not list any before any been created" do
		visit breweries_path
		expect(page).to have_content "Listing breweries"
		expect(page).to have_content "No. of breweries: 0"
	end

	describe "when breweries exist" do
		before :each do
			@bs = ["K", "U", "P"]
			year = 1896
			@bs.each do |b_name|
				FactoryGirl.create(:brewery, name:b_name, year: year += 1)
			end
			visit breweries_path
		end
		it "should show brewery listing and total number" do
			page.should have_content "No. of breweries: #{@bs.count}"
			@bs.each do |b_name|
				page.should have_content b_name
			end
		end
		it "allows user to navigate to page of a Brewery" do
			click_link "K"
			page.should have_content "K"
			page.should have_content "Established in 1897"
		end
	end
end
