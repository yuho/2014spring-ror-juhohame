require 'spec_helper'

def bwrs(*scores, user) # bwrs == beer with ratings
	scores.each do |s|
		bwr(s,user)
	end
end

def bwr(score, user) # bwr == beer with rating
        b = FactoryGirl.create(:beer)
        FactoryGirl.create(:rating, score:score, beer:b, user:user)
        b
end

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

	let(:user){FactoryGirl.create(:user)}

	it "has the username set correctly" do
		user.username.should == "Pekka"
	end

	it "is not saved without a passworld" do
		user = User.create username:"#{uname}"
		expect(user).not_to be_valid
		User.count.should == 0
	end

	it "is saved with a proper passworld" do
		expect(user).to be_valid
		expect(User.count).to eq(1)
	end

	it "with a proper password and 2 ratings, has the correct average rating" do
		r1 = FactoryGirl.create(:rating)
		r2 = FactoryGirl.create(:rating2)
		r3 = FactoryGirl.create(:rating2)
		user.ratings << r1
		user.ratings << r2
		user.ratings << r3
		expect(user.ratings.count).to eq(3)
		user.average_rating.should eq(50.0/3)
	end

	describe "favorite beer" do
		it "has method for determining" do
			user.should respond_to :favorite_beer
		end

		it "without ratings doesn't have a" do
			user.favorite_beer.should eq(nil)
		end
		it "is the one if it is the only one" do
			b = bwr(10,user)
			user.favorite_beer.should eq(b)
		end
		it "is the one with highest rating of several rated beers" do
			bwrs(10,15,9,24,user)
			best = bwr(25, user)
			user.favorite_beer.should eq(best)
		end
	end
end
