require 'rails_helper'

RSpec.describe Weapon, type: :model do
  it 'weapon start with level 1' do
    weapon = build(:weapon, level: 0)
    expect(weapon).to_not be_valid
  end

  it 'return the correct weapon title' do
    name = FFaker::Name.first_name
    level = FFaker::Random.rand(1..99)

    weapon = build(:weapon, name: name, level: level)
    expect(weapon.title).to eq("#{name} ##{level}")
  end

  it 'return the correct power of weapon' do
    name = FFaker::Name.first_name
    level = FFaker::Random.rand(1..99)
    power_base = FFaker::Random.rand(100..1000)
    power_step = FFaker::Random.rand(10..400)

    weapon = build(:weapon, name: name, level: level, power_base: power_base, power_step: power_step)
    expect(weapon.current_power).to eq(power_base + ((level + 1) * power_step))
  end
end
