require 'rails_helper'

RSpec.describe Racer, type: :model do
  let(:race) { Race.create }

  before do
    race.finish_line = 10
  end

  describe :roll do
    context 'with NORMAL speed' do
      it 'must move position to 1 if roll is odd' do
        racer = race.racers.create name: 'Alice'
        racer.roll 1, speed: :NORMAL
        expect(racer.position).to eql 1

        racer = race.racers.create name: 'Alice'
        racer.roll 3, speed: :NORMAL
        expect(racer.position).to eql 1

        racer = race.racers.create name: 'Alice'
        racer.roll 5, speed: :NORMAL
        expect(racer.position).to eql 1
      end

      it 'must move position to 2 if roll is even' do
        racer = race.racers.create name: 'Alice'
        racer.roll 2, speed: :NORMAL
        expect(racer.position).to eql 2

        racer = race.racers.create name: 'Alice'
        racer.roll 4, speed: :NORMAL
        expect(racer.position).to eql 2

        racer = race.racers.create name: 'Alice'
        racer.roll 6, speed: :NORMAL
        expect(racer.position).to eql 2
      end

      it 'must deduct damage before moving' do
        racer = race.racers.create name: 'Alice'
        racer.damage = 1
        racer.roll 1, speed: :NORMAL

        expect(racer.position).to eql 0
      end

      it 'must not move backwards' do
        racer = race.racers.create name: 'Alice'
        racer.damage = 2
        racer.roll 1, speed: :NORMAL

        expect(racer.position).to eql 0
      end
    end

    context 'with SUPER speed' do
      it 'must move position to roll and add 1 damage' do
        racer = race.racers.create name: 'Alice'
        racer.roll 1, speed: :SUPER
        expect(racer.position).to eql 1
        expect(racer.damage).to eql 2

        racer = race.racers.create name: 'Alice'
        racer.roll 2, speed: :SUPER
        expect(racer.position).to eql 2
        expect(racer.damage).to eql 2

        racer = race.racers.create name: 'Alice'
        racer.roll 3, speed: :SUPER
        expect(racer.position).to eql 3
        expect(racer.damage).to eql 2

        racer = race.racers.create name: 'Alice'
        racer.roll 4, speed: :SUPER
        expect(racer.position).to eql 4
        expect(racer.damage).to eql 2

        racer = race.racers.create name: 'Alice'
        racer.roll 5, speed: :SUPER
        expect(racer.position).to eql 5
        expect(racer.damage).to eql 2

        racer = race.racers.create name: 'Alice'
        racer.roll 6, speed: :SUPER
        expect(racer.position).to eql 6
        expect(racer.damage).to eql 2
      end

      it 'must deduct damage before moving' do
        racer = race.racers.create name: 'Alice'
        racer.damage = 1
        racer.roll 1, speed: :SUPER

        expect(racer.position).to eql 0
        expect(racer.damage).to eql 3
      end

      it 'must not move backwards' do
        racer = race.racers.create name: 'Alice'
        racer.damage = 2
        racer.roll 1, speed: :SUPER

        expect(racer.position).to eql 0
        expect(racer.damage).to eql 4
      end
    end

    it 'must log roll' do
      racer = race.racers.create name: 'Alice'
      racer.position = 1
      racer.damage = 2
      racer.save

      racer.roll 6, speed: :SUPER

      expect(racer.rolls.last).to have_attributes position:     1,
                                                  damage:       2,
                                                  speed:        'SUPER',
                                                  roll:         6,
                                                  move:         4,
                                                  new_position: 5
    end
  end

  describe :won? do
    it 'must return true if position is equal finish line' do
      racer = race.racers.create name: 'Alice'
      racer.position = 10

      expect(racer).to be_won
    end
  end
end
