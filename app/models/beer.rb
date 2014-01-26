class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
    avg=0
    ratings = Rating.where(beer_id:"#{self.id}")
    ratings.each do |r|
      avg += r.score.to_f/ratings.count
    end
    return avg
  end
end

