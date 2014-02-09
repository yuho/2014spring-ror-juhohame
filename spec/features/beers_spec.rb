require 'spec_helper.rb'

describe "Possibility" do
	it "to add a beer" do
		FactoryGirl.create :brewery, name: "K"
		visit new_beer_path
		fill_in("beer_name", with:"B")
	expect{
		click_button("Create Beer")
	}.to change{Beer.count}.from(0).to(1)
	end
	describe "to fail adding a beer" do
		it "when name is invalid" do
			FactoryGirl.create :brewery, name: "K"
			visit new_beer_path
			expect{
				click_button("Create Beer")
			}.to_not change{Beer.count}.from(0).to(1)
		end
		it "and see some error message" do
			FactoryGirl.create :brewery, name: "K"
			visit new_beer_path
			click_button("Create Beer")
			expect(page).to have_content "errors prohibited this beer from being saved"
		end
	end
end
