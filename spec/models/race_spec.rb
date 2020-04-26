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
    end

    it 'must return false if no racers crashed' do
      race = Race.create

      race.racers.create name: 'Alice'
      race.racers.create name: 'Bob'
      race.racers.create name: 'Charlie'

      expect(race).not_to be_all_crashed
    end

    it 'must return false if only some racers crashed' do
      race = Race.create

      race.racers.create name: 'Racer 1', damage: Racer::MAX_DAMAGE
      race.racers.create name: 'Racer 2'
      race.racers.create name: 'Racer 3', damage: Racer::MAX_DAMAGE

      expect(race).not_to be_all_crashed
    end
  end

  describe :current_rank do
    it 'must be nil if no racers' do
      race = Race.create

      expect(race.current_rank).to be_nil
    end

    it 'must be set to 1 if first racer added' do
      race = Race.create
      race.racers.create name: 'Alice'

      expect(race.current_rank).to eql 1
    end

    it 'must not replace current_rank if already set' do
      race = Race.create
      race.racers.create name: 'Alice'
      race.racers.create name: 'Bob'

      expect(race.current_rank).to eql 1
    end
  end

  describe :roll do
    it 'must move current_rank to next racer after roll' do
      race = Race.create

      race.racers.create name: 'Alice'
      racer2 = race.racers.create name: 'Bob'
      race.racers.create name: 'Charlie'
      race.racers.create name: 'Dave'

      race.roll 1, speed: :NORMAL

      expect(race.last_roll).not_to be_nil
      expect(race.current_rank).to eql racer2.id
      expect(race.current_racer).to eql racer2
    end

    it 'must move current_rank to first racer after last racer' do
      race = Race.create

      racer = race.racers.create name: 'Alice'
      race.racers.create name: 'Bob'
      race.racers.create name: 'Charlie'
      racer4 = race.racers.create name: 'Dave'

      race.update current_rank: racer4.rank

      race.roll 1, speed: :NORMAL

      expect(race.last_roll).not_to be_nil
      expect(race.current_rank).to eql racer.id
      expect(race.current_racer).to eql racer
    end
  end

  describe :over? do
    it 'must return false if no racer won yet' do
      race = Race.create
      race.update finish_line: 10

      race.racers.create name: 'Alice'
      race.racers.create name: 'Bob'
      race.racers.create name: 'Charlie'
      race.racers.create name: 'Dave'

      expect(race).not_to be_over
    end

    it 'must return true if one racer crossed the finish line' do
      race = Race.create
      race.update finish_line: 10

      race.racers.create name: 'Alice'
      race.racers.create name: 'Bob', position: race.finish_line
      race.racers.create name: 'Charlie'
      race.racers.create name: 'Dave'

      expect(race).to be_over
    end

    it 'must return true if all racers crashed' do
      race = Race.create
      race.update finish_line: 10

      race.racers.create name: 'Racer 1', damage: Racer::MAX_DAMAGE
      race.racers.create name: 'Racer 2', damage: Racer::MAX_DAMAGE
      race.racers.create name: 'Racer 3', damage: Racer::MAX_DAMAGE

      expect(race).to be_over
    end
  end
end
