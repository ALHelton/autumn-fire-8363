require 'rails_helper'

RSpec.describe 'Garden Show Page', type: :feature do
  let!(:garden1) { Garden.create!(name: "Turing Community Garden", organic: true) }
  let!(:garden2) { Garden.create!(name: "Other Garden", organic: false) }

  let!(:plot1) { Plot.create!(number: 1, size: "Large", direction: "East", garden_id: garden1.id) }
  let!(:plot2) { Plot.create!(number: 2, size: "Small", direction: "North", garden_id: garden1.id) }
  let!(:plot3) { Plot.create!(number: 3, size: "Medium", direction: "West", garden_id: garden1.id) }

  let!(:plot4) { Plot.create!(number: 4, size: "Large", direction: "South", garden_id: garden2.id) }

  let!(:plot5) { Plot.create!(number: 5, size: "Medium", direction: "West", garden_id: garden1.id) }

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

    PlantPlot.create!(plant: carrots, plot: plot5)

    #beans --> 2
    #carrots --> 3
    #onions --> 1

    visit "/garden/#{garden1.id}"
  end

  it 'I see a list of plants that are included in that garden`s plots, no duplicates, only plants less than 100 days to harvest' do
    expect(page).to have_content("Turing Community Garden Plants")
    expect(page).to have_content("All Plants Less Than 100 Days to Harvest:")
    expect(page).to have_content("Beans")
    expect(page).to have_content("Carrots")
    expect(page).to have_content("Onions")
    expect(page).to_not have_content("Tomatos")
    expect(page).to_not have_content("Cabbage")
    
    expect(page).to_not have_content("Other Garden Plants")
    expect(page).to_not have_content("Broccoli")
  end

  describe 'extension' do
    xit 'Then I see the list of plants is sorted by the number of times the plant appears in any of that garden`s plots from most to least' do
      expect("Carrots").to appear_before("Beans")
      expect("Beans").to appear_before("Onions")
    end
  end
end