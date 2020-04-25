require 'rails_helper'

RSpec.describe Race, type: :model do
  describe :last_roll do
    it 'must return last roll' do
      race = Race.create

      racer = race.racers.create name: 'Alice'

      racer.roll(1, speed: :NORMAL)
      racer.roll(2, speed: :NORMAL)

      expect(race.last_roll).to eql race.rolls.last
    end

    it 'must return nil if no rolls yet' do
      race = Race.create

      expect(race.last_roll).to be_nil
    end
  end
end
