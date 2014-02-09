require 'spec_helper.rb'

describe "Possibility" do
	it "list users ratings" do
		u = User.create(username:"Juho", password:"Passwor1d", password_confirmation:"Passwor1d")
		br = Brewery.create(name:"K",year:1900)
		b = Beer.create(name:"Phil", brewery_id:br.id, style:"Lager")
		a = Rating.create(score:10, beer_id:b.id, user_id:u.id)
#		b = Rating.create(score:15, beer_id:b.id, user_id:u.id)
		c = Rating.create(score:20, beer_id:b.id, user_id:u.id)
		d = Rating.create(score:18, beer_id:b.id, user_id:u.id)
		e = Rating.create(score:1, beer_id:b.id, user_id:u.id)
		f = Rating.create(score:2, beer_id:b.id, user_id:u.id)
		g = Rating.create(score:6, beer_id:b.id, user_id:u.id)
		visit user_path(u)
		[a,c,d,e,f,g].each do |r|
			expect(page).to have_content r.score
			expect(page).to have_content Beer.find_by(id:r.beer_id).name
		end
	end

	it "list all ratings" do
		u = User.create(username:"Juho", password:"Passwor1d", password_confirmation:"Passwor1d")
		br = Brewery.create(name:"K",year:1900)
		b = Beer.create(name:"Phil", brewery_id:br.id, style:"Lager")
		a = Rating.create(score:10, beer_id:b.id, user_id:u.id)
#		b = Rating.create(score:15, beer_id:b.id, user_id:u.id)
		c = Rating.create(score:20, beer_id:b.id, user_id:u.id)
		d = Rating.create(score:18, beer_id:b.id, user_id:u.id)
		e = Rating.create(score:1, beer_id:b.id, user_id:u.id)
		f = Rating.create(score:2, beer_id:b.id, user_id:u.id)
		g = Rating.create(score:6, beer_id:b.id, user_id:u.id)
		visit ratings_path
		expect(page).to have_content "6 ratings altogether"
		[a,c,d,e,f,g].each do |r|
			expect(page).to have_content r.score
			expect(page).to have_content Beer.find_by(id:r.beer_id).name
		end
	end
end
