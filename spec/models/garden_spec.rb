require 'rails_helper'

RSpec.describe Garden do
  let!(:garden1) { Garden.create!(name: "Turing Community Garden", organic: true) }
  let!(:garden2) { Garden.create!(name: "Other Garden", organic: false) }

  let!(:plot1) { Plot.create!(number: 1, size: "Large", direction: "East", garden_id: garden1.id) }
  let!(:plot2) { Plot.create!(number: 2, size: "Small", direction: "North", garden_id: garden1.id) }
  let!(:plot3) { Plot.create!(number: 3, size: "Medium", direction: "West", garden_id: garden1.id) }

  let!(:plot4) { Plot.create!(number: 4, size: "Large", direction: "South", garden_id: garden2.id) }

  let!(:tomatos) { Plant.create!(name: "Tomatos", description: "It's tomatos", days_to_harvest: 100) }
  let!(:beans) { Plant.create!(name: "Beans", description: "It's Beans", days_to_harvest: 50) }
  let!(:carrots) { Plant.create!(name: "Carrots", description: "It's carrots", days_to_harvest: 80) }
  let!(:onions) { Plant.create!(name: "Onions", description: "It's onions", days_to_harvest: 80) }

  let!(:cabbage) { Plant.create!(name: "Cabbage", description: "It's a cabbage", days_to_harvest: 150) }

  let!(:broccoli) { Plant.create!(name: "Broccoli", description: "It's broccoli", days_to_harvest: 150) }

  before do
    PlantPlot.create!(plant: tomatos, plot: plot1)
    PlantPlot.create!(plant: beans, plot: plot1)

    PlantPlot.create!(plant: carrots, plot: plot2)
    PlantPlot.create!(plant: cabbage, plot: plot2)
    PlantPlot.create!(plant: tomatos, plot: plot2)

    PlantPlot.create!(plant: onions, plot: plot3)
    PlantPlot.create!(plant: carrots, plot: plot3)
    PlantPlot.create!(plant: beans, plot: plot3)

    PlantPlot.create!(plant: broccoli, plot: plot4)
  end

  describe 'relationships' do
    it { should have_many(:plots) }
    it { should have_many(:plants).through(:plots) }
  end

  describe 'instance methods' do
    it 'under_hundred_days_to_harvest_plants' do
      expect(garden1.under_hundred_days_to_harvest_plants).to eq([beans, carrots, onions])
    end
  end
end
