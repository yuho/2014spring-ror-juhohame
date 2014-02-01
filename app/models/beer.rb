class Beer < ActiveRecord::Base
  include RatingAverage

  belongs_to :brewery
  has_many :ratings, dependent: :destroy

  def average_rating
    Rating.where(beer_id:"#{self.id}").pluck("score").inject(:+).to_f/Rating.where(beer_id:"#{self.id}").count
  end

  def to_s
    "#{name} #{brewery.name}"
  end
end

