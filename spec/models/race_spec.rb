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

  describe :all_crashed? do
    it 'must return true if all racers crashed' do
      race = Race.create

      race.racers.create name: 'Racer 1', damage: Racer::MAX_DAMAGE
      race.racers.create name: 'Racer 2', damage: Racer::MAX_DAMAGE
      race.racers.create name: 'Racer 3', damage: Racer::MAX_DAMAGE

      expect(race).to be_all_crashed
      expect(race).to be_over
    end

    it 'must return false if no racers crashed' do
      race = Race.create

      race.racers.create name: 'Alice'
      race.racers.create name: 'Bob'
      race.racers.create name: 'Charlie'

      expect(race).not_to be_all_crashed
      expect(race).not_to be_over
    end

    it 'must return false if only some racers crashed' do
      race = Race.create

      race.racers.create name: 'Racer 1', damage: Racer::MAX_DAMAGE
      race.racers.create name: 'Racer 2'
      race.racers.create name: 'Racer 3', damage: Racer::MAX_DAMAGE

      expect(race).not_to be_all_crashed
      expect(race).not_to be_over
    end
  end
end
