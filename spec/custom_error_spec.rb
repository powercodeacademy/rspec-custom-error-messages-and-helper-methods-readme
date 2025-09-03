
require 'garden_plot'

RSpec.describe GardenPlot do
  let(:plot) { GardenPlot.new }
  let(:tomato) { Plant.new('Tomato') }
  let(:carrot) { Plant.new('Carrot', height: 2) }
  let(:sunflower) { Plant.new('Sunflower', height: 5) }

  def water_and_grow(plant, sunlight: 0)
    plant.water!
    plant.give_sunlight(sunlight)
    plant.grow!
  end

  describe 'adding and finding plants' do
    it 'adds plants to the plot' do
      plot.add_plant(tomato)
      expect(plot.plants).to include(tomato), "Expected plot to include Tomato, but got: #{plot.plants.map(&:name)}"
    end

    it 'finds the tallest plant' do
      plot.add_plant(carrot)
      plot.add_plant(sunflower)
      expect(plot.tallest_plant.name).to eq('Sunflower'), "Tallest plant should be Sunflower, got #{plot.tallest_plant.name}"
    end
  end

  describe 'watering and growth' do
    it 'marks a plant as watered' do
      tomato.water!
       expect(tomato.watered).to eq(true), "Expected Tomato to be watered, but it wasn't"
    end

    it 'grows more with enough sunlight' do
      tomato.water!
      tomato.give_sunlight(5)
      expect { tomato.grow! }.to change { tomato.height }.by(2), "Tomato should grow by 2 with enough sunlight"
    end

    it 'grows less with insufficient sunlight' do
      tomato.water!
      tomato.give_sunlight(2)
      expect { tomato.grow! }.to change { tomato.height }.by(1), "Tomato should grow by 1 with little sunlight"
    end

    it 'resets watered and sunlight after growing' do
      tomato.water!
      tomato.give_sunlight(4)
      tomato.grow!
      expect(tomato.watered).to eq(false), "Expected watered to reset after growing"
      expect(tomato.sunlight_hours).to eq(0), "Expected sunlight_hours to reset after growing"
    end
  end

  describe 'helper methods for repeated logic' do
    it 'waters and grows a plant with helper' do
      expect { water_and_grow(carrot, sunlight: 4) }.to change { carrot.height }.by(2)
    end

    it 'waters and grows a plant with little sunlight using helper' do
      expect { water_and_grow(carrot, sunlight: 1) }.to change { carrot.height }.by(1)
    end
  end

  describe 'plot-wide checks' do
    it 'checks if all plants are watered' do
      plot.add_plant(tomato)
      plot.add_plant(carrot)
      tomato.water!
      carrot.water!
      expect(plot.all_watered?).to eq(true), "All plants should be watered"
    end

    it 'shows not all plants are watered (custom message)' do
      plot.add_plant(tomato)
      plot.add_plant(carrot)
      tomato.water!
      expect(plot.all_watered?).to eq(false), "Expected all_watered? to be false when not all plants are watered"
    end
  end

  describe 'pending specs for students' do
    it 'test that a plant does not grow if not watered' do
      tomato.give_sunlight(4)
      expect { tomato.grow! }.to change { tomato.height }.by(0), "Expected plant not to grow with no water"
    end

    it 'is pending: test that tallest_plant returns nil if plot is empty' do
      pending("Student: Write a spec for tallest_plant on empty plot")
      raise "Unimplemented pending spec"
    end
  end
end
