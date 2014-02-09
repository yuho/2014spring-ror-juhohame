require 'spec_helper'

describe "User" do
	before :each do
		FactoryGirl.create :user
	end

	describe "who has signed up" do
		it "can signin with correct credentials" do
			visit signin_path
			fill_in('username', with:'Pekka')
    		fill_in('password', with:'Foobar1')
			click_button('Log in')

			expect(page).to have_content 'Pekka is signed in'
			expect(page).to have_content 'Pekka'
		end
		it "cannot sign in with incorrect credentials" do
			visit signin_path
			fill_in("username", with: "Pekka")
			fill_in("password", with:"Foobar2")
			click_button("Log in")
			current_path.should eq(signin_path)
			page.should have_content "USERSNAME"
		end
	end
end
