require 'rails_helper' 

RSpec.describe 'Plots Index Page', type: :feature do
  let!(:plot1) { Plot.create!(number: 1, size: "Large", direction: "East") }
  let!(:plot2) { Plot.create!(number: 2, size: "Small", direction: "North") }
  let!(:plot3) { Plot.create!(number: 3, size: "Medium", direction: "West") }

  let!(:tomatos) { Plant.create!(name: "Tomatos", description: "It's tomatos", days_to_harvest: 100) }
  let!(:beans) { Plant.create!(name: "Beans", description: "It's Beans", days_to_harvest: 50) }
  let!(:carrots) { Plant.create!(name: "Carrots", description: "It's carrots", days_to_harvest: 80) }
  let!(:onions) { Plant.create!(name: "Onions", description: "It's onions", days_to_harvest: 80) }


  let!(:cabbage) { Plant.create!(name: "Cabbage", description: "It's a cabbage", days_to_harvest: 150) }

  before do
    PlotPlant.create!(plant: tomatos, plot: plot1)
    PlotPlant.create!(plant: beans, plot: plot1)

    PlotPlant.create!(plant: carrots, plot: plot2)
    PlotPlant.create!(plant: cabbage, plot: plot2)
    PlotPlant.create!(plant: tomatos, plot: plot2)

    PlotPlant.create!(plant: onions, plot: plot3)
    PlotPlant.create!(plant: carrots, plot: plot3)
    PlotPlant.create!(plant: beans, plot: plot3)

    visit "/plots"
  end

  it 'I see a list of all plot numbers, under each plot number I see the names of all that plot`s plants' do
    within "#plot-#{plot1.id}" do
      expect(page).to have_content(1)
      expect(page).to have_content("Tomatos")
      expect(page).to have_content("Beans")

      expect(page).to_not have_content("Cabbage")
      expect(page).to_not have_content("Onions")
      expect(page).to_not have_content("Carrots")

    end 

    within "#plot-#{plot2.id}" do
      expect(page).to have_content(2)
      expect(page).to have_content("Carrots")
      expect(page).to have_content("Cabbage")
      expect(page).to have_content("Tomatos")

      expect(page).to_not have_content("Onions")
      expect(page).to_not have_content("Beans")
    end

    within "#plot-#{plot3.id}" do
      expect(page).to have_content(3)
      expect(page).to have_content("Onions")
      expect(page).to have_content("Carrots")
      expect(page).to have_content("Beans")

      expect(page).to_not have_content("Cabbage")
      expect(page).to_not have_content("Tomatos")
    end
  end

end