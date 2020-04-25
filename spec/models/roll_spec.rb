require 'rails_helper'

RSpec.describe Roll, type: :model do
  describe :crashed? do
    it 'must return true if new damage is equal to max damage' do
      roll = Roll.new
      roll.new_damage = Roll::MAX_DAMAGE

      expect(roll).to be_crashed
    end

    it 'must return true if new damage is greater than max damage' do
      roll = Roll.new
      roll.new_damage = (Roll::MAX_DAMAGE + 1)

      expect(roll).to be_crashed
    end

    it 'must return false if new damage is less than max damage' do
      roll = Roll.new
      roll.new_damage = (Roll::MAX_DAMAGE - 1)

      expect(roll).not_to be_crashed
    end
  end
end
