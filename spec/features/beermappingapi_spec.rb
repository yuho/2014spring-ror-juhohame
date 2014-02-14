require 'spec_helper'

describe "BeermappingApi using HTTP GETs" do
	it "no entries, api returns empty array" do
		canned = File.read(File.expand_path("lib/dummynone_bmp.xml"))
        stub_request(:get, /.*tampere/).to_return(body: canned, headers: {'Content-Type'=> "text/xml"})
        places = BeermappingApi.places_in("HERE IS THE CITY tampere")
		places.size.should eq(0)
	end

	it "one entry, it is parsed and returned" do
		canned = File.read(File.expand_path("lib/dummy_bmp.xml"))[0..-2]
		stub_request(:get, /.*tampere/).to_return(body: canned, headers: {'Content-Type'=> "text/xml"})
		places = BeermappingApi.places_in("HERE IS THE CITY tampere")
		expect(places.size).to eq(1)
		expect(places.first.name).to eq("O'Connell's Irish Bar")
		expect(places.first.street).to eq("Rautatienkatu 24")
	end

	it "multiple entries, they are all parsed as Place objects (and returned)" do
        canned = File.read(File.expand_path("lib/dummymcw_bmp.xml"))
#		canned =
#<<-ENDOFSTRING
#<?xml version='1.0' encoding='utf-8' ?><bmp_locations><location><id>6556</id><name>Alehouse, The (Coeur d'Alene)</name><status>Brewpub</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=6556</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=6556&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=6556&amp;d=1&amp;type=norm</blogmap><street>226 W. Sixth Street</street><city>Moscow</city><state>ID</state><zip>83843</zip><country>United States</country><phone>(208) 882-2739</phone><overall>70.0001</overall><imagecount>0</imagecount></location><location><id>17702</id><name>Moscow Brewing Company</name><status>Brewery</status><reviewlink>http://beermapping.com/maps/reviews/reviews.php?locid=17702</reviewlink><proxylink>http://beermapping.com/maps/proxymaps.php?locid=17702&amp;d=5</proxylink><blogmap>http://beermapping.com/maps/blogproxy.php?locid=17702&amp;d=1&amp;type=norm</blogmap><street>630 N. Almon</street><city>Moscow</city><state>ID</state><zip>83843</zip><country>United States</country><phone>(208) 874-7340</phone><overall>0</overall><imagecount>0</imagecount></location></bmp_locations>
#ENDOFSTRING

		stub_request(:get, /.*tampere/).to_return(body: canned, headers: {'Content-Type'=> "text/xml"})
        places = BeermappingApi.places_in("HERE IS THE CITY tampere")
        expect(places.size).to eq(2)
		places.each { |p|
			p.should.respond_to?(:name)
			p.should.respond_to?(:status)
			p.should.respond_to?(:street)
		}
	end

end
