class User < ActiveRecord::Base
  include RatingAverage

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings

  validates :username, length: {
    minimum: 3, maximum: 15
  }

end
