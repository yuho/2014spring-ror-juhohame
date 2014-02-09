require 'spec_helper'

describe Beer do
	describe "has name and style" do
		let(:b){Beer.new name:"Le Beer", style:"Alcoholic"}
		it "is valid" do
			b.should be_valid
		end
		it "is saved" do
			b.save
			Beer.should have_exactly(1).items
		end
	end
	describe "does not have (this) and hence not saved" do
		it "name" do
			b = Beer.create style:"Alcoholic"
			Beer.should have_exactly(0).items
		end
		it "style" do
			b = Beer.create name:"La Birra"
			Beer.should have_exactly(0).items
		end
	end
end
