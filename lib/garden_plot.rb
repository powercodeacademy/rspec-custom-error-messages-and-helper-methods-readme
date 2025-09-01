# frozen_string_literal: true

# Represents a plant in a garden plot
class Plant
  attr_reader :name, :height, :watered, :sunlight_hours

  def initialize(name, height: 0, watered: false, sunlight_hours: 0)
    @name = name
    @height = height
    @watered = watered
    @sunlight_hours = sunlight_hours
  end

  def water!
    @watered = true
  end

  def give_sunlight(hours)
    @sunlight_hours += hours
  end

  def grow!
    if @watered && @sunlight_hours >= 4
      @height += 2
    elsif @watered
      @height += 1
    end
    @watered = false
    @sunlight_hours = 0
  end
end

# Represents a garden plot containing multiple plants
class GardenPlot
  attr_reader :plants

  def initialize
    @plants = []
  end

  def add_plant(plant)
    @plants << plant
  end

  def tallest_plant
    @plants.max_by(&:height)
  end

  def all_watered?
    @plants.all?(&:watered)
  end
end
