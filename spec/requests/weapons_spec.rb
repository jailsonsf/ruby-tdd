require 'rails_helper'

RSpec.describe 'Weapons', type: :request do
  before(:all) do
    @weapon = build(:weapon)
  end

  describe 'GET /weapons' do
    it 'returns success status' do
      get weapons_path
      expect(response).to have_http_status(200)
    end
    it 'the weapons name, current_power, title are present' do
      weapons = create_list(:weapon, 3)
      get weapons_path
      weapons.each do |weapon|
        expect(response.body).to include(weapon.name)
          .and include(weapon.current_power.to_s)
          .and include(weapon.title)
      end
    end
  end

  describe 'POST /weapons' do
    context 'when it has valid parameters' do
      it 'creates the weapon with correct attributes' do
        weapon_attributes = FactoryBot.attributes_for(:weapon)
        post weapons_path, params: { weapon: weapon_attributes }
        expect(Weapon.last).to have_attributes(weapon_attributes)
      end
    end

    context 'when it has no valid parameters' do
      it 'does not create weapon' do
        expect do
          post weapons_path, params: {
            weapon: {
              name: '',
              description: '',
              power_base: 0,
              power_step: 0,
              level: 0
            }
          }
        end.to_not change(User, :count)
      end
    end
  end

  describe 'DELETE /weapons/:id' do
    it 'delete a weapon using id' do
      @weapon.destroy
      expect(Weapon.count).to eq(0)
    end
  end

  describe 'GET /weapons/:id' do
    it 'returns success status' do
      get weapons_path(id: @weapon.id)
      expect(response).to have_http_status(200)
    end
    it 'the weapons details are present' do
      weapon = create(:weapon)
      get weapon_path(id: weapon.id)
      expect(response.body).to include(weapon.title)
        .and include(weapon.name)
        .and include(weapon.description)
        .and include(weapon.level.to_s)
        .and include(weapon.power_base.to_s)
        .and include(weapon.power_step.to_s)
        .and include(weapon.current_power.to_s)
    end
  end
end
