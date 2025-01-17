class Garden < ApplicationRecord
  has_many :plots
  has_many :plants, through: :plots

  def under_hundred_days_to_harvest_plants
    plants.where('days_to_harvest < 100').distinct
  end
end
