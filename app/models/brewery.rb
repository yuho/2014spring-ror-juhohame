class Brewery < ActiveRecord::Base
  include RatingAverage

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	validates :name, presence: true
        validates :year, numericality: {
          more_than_or_equal_to: 1042,
          less_than_or_equal_to: 2014,
          only_integer: true
        }

	validates :year, :inclusion => { :in => proc { 1024..Time.now.year } }

end
