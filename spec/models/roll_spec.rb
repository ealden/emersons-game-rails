require 'rails_helper'

RSpec.describe Roll, type: :model do
  describe :damaged? do
    it 'must be false if no damage' do
      roll = Roll.new

      expect(roll).not_to be_damaged
    end

    it 'must be true if at least 1 damage' do
      roll = Roll.new
      roll.damage = 1

      expect(roll).to be_damaged
    end
  end
end
