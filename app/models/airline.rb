class Airline < ApplicationRecord
  has_many :flights
  has_many :passengers, through: :flights

  def adult_passengers
    passengers.where("passengers.age > ?", 17).distinct.pluck(:name)
  end
end
