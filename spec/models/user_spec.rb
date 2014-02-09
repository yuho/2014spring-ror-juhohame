require 'spec_helper'

describe User do
	it "has the username set correctly" do
		@uname = "Peca"
		user = User.new username:"@uname"
		user.username.should == "@uname"
	end

	it "is not saved without a passworld" do
		user = User.create username:"@uname"
		expect(user).not_to be_valid
		User.count.should == 0
	end
end
