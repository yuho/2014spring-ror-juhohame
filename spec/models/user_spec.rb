require 'spec_helper'

describe User do
	uname = "Peca"
	pw = "Passwor1d"

	describe "is not valid" do
		it "has a username of length 2" do
			user = User.new username:"2l"
			user.should_not be_valid
		end
		it "has the passworld of only letters" do
			user = User.new username:"#{uname}", password:"OnLyLeTtErS", password_confirmation:"OnLyLeTtErS"
			user.should_not be_valid
		end
	end

	describe "is not saved" do
		it "has a username of length 2" do
			user = User.create username:"2l"
			User.should_not have_at_least(1).items
		end

		it "has the password of only letters" do
			user = User.create username:"#{uname}", password:"OnLyLeTtErS", password_confirmation:"OnLyLeTtErS"
			User.should have_at_most(0).items
		end
	end

	it "has the username set correctly" do
		user = User.new username:"#{uname}"
		user.username.should == "#{uname}"
	end

	it "is not saved without a passworld" do
		user = User.create username:"#{uname}"
		expect(user).not_to be_valid
		User.count.should == 0
	end

	it "is saved with a proper passworld" do
		user = User.create username:"#{uname}", password:"#{pw}", password_confirmation:"#{pw}"
		expect(user).to be_valid
		expect(User.count).to eq(1)
	end

	it "with a proper password and 2 ratings, has the correct average rating" do
		user = User.create username:"#{uname}", password:"#{pw}", password_confirmation:"#{pw}"
		r1 = Rating.new score:10
		r2 = Rating.new score:20
		user.ratings << r1
		user.ratings << r2
		expect(user.ratings.count).to eq(2)
		user.average_rating.should eq(15.0)
	end
end
