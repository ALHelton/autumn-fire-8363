require 'rails_helper' 

RSpec.describe 'Plots Index Page', type: :feature do
  let!(:garden1) { Garden.create!(name: "Turing Community Garden", organic: true) }

  let!(:plot1) { Plot.create!(number: 1, size: "Large", direction: "East", garden_id: garden1.id) }
  let!(:plot2) { Plot.create!(number: 2, size: "Small", direction: "North", garden_id: garden1.id) }
  let!(:plot3) { Plot.create!(number: 3, size: "Medium", direction: "West", garden_id: garden1.id) }

  let!(:tomatos) { Plant.create!(name: "Tomatos", description: "It's tomatos", days_to_harvest: 100) }
  let!(:beans) { Plant.create!(name: "Beans", description: "It's Beans", days_to_harvest: 50) }
  let!(:carrots) { Plant.create!(name: "Carrots", description: "It's carrots", days_to_harvest: 80) }
  let!(:onions) { Plant.create!(name: "Onions", description: "It's onions", days_to_harvest: 80) }

  let!(:cabbage) { Plant.create!(name: "Cabbage", description: "It's a cabbage", days_to_harvest: 150) }

  before do
    PlantPlot.create!(plant: tomatos, plot: plot1)
    PlantPlot.create!(plant: beans, plot: plot1)

    PlantPlot.create!(plant: carrots, plot: plot2)
    PlantPlot.create!(plant: cabbage, plot: plot2)
    PlantPlot.create!(plant: tomatos, plot: plot2)

    PlantPlot.create!(plant: onions, plot: plot3)
    PlantPlot.create!(plant: carrots, plot: plot3)
    PlantPlot.create!(plant: beans, plot: plot3)

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

  it 'Next to each plant name, I see a link or button to remove that plant from the plot' do
    expect(page).to have_link("Delete", count: 8)
  end

  it "When I click on delete, returned to the plots index page, no longer see plant listed under that plot, and still see that plant's name under other plots" do
    
    within "#plot-#{plot1.id}" do
    
      first(:link, "Delete").click

      expect(current_path).to eq("/plots")
      expect(page).to_not have_content("Tomatos")
    end
  end
end