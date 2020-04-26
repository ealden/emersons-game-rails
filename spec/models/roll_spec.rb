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

  describe :normal_speed? do
    it 'must be true if speed is NORMAL' do
      roll = Roll.new
      roll.speed = :NORMAL.to_s

      expect(roll).to be_normal_speed
    end

    it 'must be false if speed is :SUPER' do
      roll = Roll.new
      roll.speed = :SUPER.to_s

      expect(roll).not_to be_normal_speed
    end
  end
end
