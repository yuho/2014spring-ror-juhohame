class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    Rating.where(beer_id:"#{self.id}").pluck("score").inject(:+).to_f/Rating.where(beer_id:"#{self.id}").count
  end

  def to_s
    "#{self.name} by " + Brewery.find_by("#{self.brewery_id}").name
  end
end

