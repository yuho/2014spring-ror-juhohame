class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  has_many :ratings
  has_many :beers, through: :ratings

  validates :username, length: {
    in: 3..15
  }

  validates :password, length: {
    minimum: 4
  }

  validates :password, format: {
    with: /(.*)(([A-Z].*[0-9])|([0-9].*[A-Z]))(.*)/, message: "must match: /([A-Z].*[0-9])|([0-9].*[A-Z])/"
  }

end
