# test/models/chandrayaan_spec.rb
require 'rails_helper'

RSpec.describe Chandrayaan, type: :model do
  it "navigation with basic commands" do
    chandrayaan = Chandrayaan.new([0, 0, 0], 'N')
    chandrayaan.execute_commands(["f", "r", "u", "b", "l"])
    assert_equal({ position: [0, 1, -1], direction: 'N' }, chandrayaan.final_state)
  end

  it "navigation with different initial direction" do
    chandrayaan = Chandrayaan.new([0, 0, 0], 'W')
    chandrayaan.execute_commands(["f", "r", "u", "b", "l"])
    assert_equal({ position: [-1, 0, -1], direction: 'N' }, chandrayaan.final_state)
  end

  it "navigation with multiple movements in one direction" do
    chandrayaan = Chandrayaan.new([0, 0, 0], 'E')
    chandrayaan.execute_commands(["f", "f", "f"])
    assert_equal({ position: [3, 0, 0], direction: 'E' }, chandrayaan.final_state)
  end

  it "navigation with turns and tilt" do
    chandrayaan = Chandrayaan.new([0, 0, 0], 'N')
    chandrayaan.execute_commands(["r", "u", "r", "l", "d"])
    assert_equal({ position: [0, 0, 0], direction: 'D' }, chandrayaan.final_state)
  end
end
