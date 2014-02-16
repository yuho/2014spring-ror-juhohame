b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

b1.beers.create name:"Iso 3", style_id:1
b1.beers.create name:"Karhu", style_id:1
b1.beers.create name:"Tuplahumala", style_id:1
b2.beers.create name:"Huvila Pale Ale", style_id:2
b2.beers.create name:"X Porter", style_id:3
b3.beers.create name:"Hefezeizen", style_id:4
b3.beers.create name:"Helles", style_id:1

Style.create name:"Hello", description:"This is a greeting"
Style.create name:"World", description:"This is the world"
Style.create name:"Foo", description:"This is a placeholder"
Style.create name:"Bar", description:"This is also a placeholder"

User.create username:"Juho1",password:"Hello1",password_confirmation:"Hello1"
User.create username:"Juho2",password:"Hello1",password_confirmation:"Hello1"
User.create username:"Juho3",password:"Hello1",password_confirmation:"Hello1"
