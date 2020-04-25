require 'rails_helper'

RSpec.describe Racer, type: :model do
  describe :roll do
    context 'with NORMAL speed' do
      it 'must move position to 1 if roll is odd' do
        racer = Racer.new
        racer.roll 1, speed: :NORMAL
        expect(racer.position).to eql 1

        racer = Racer.new
        racer.roll 3, speed: :NORMAL
        expect(racer.position).to eql 1

        racer = Racer.new
        racer.roll 5, speed: :NORMAL
        expect(racer.position).to eql 1
      end

      it 'must move position to 2 if roll is even' do
        racer = Racer.new
        racer.roll 2, speed: :NORMAL
        expect(racer.position).to eql 2

        racer = Racer.new
        racer.roll 4, speed: :NORMAL
        expect(racer.position).to eql 2

        racer = Racer.new
        racer.roll 6, speed: :NORMAL
        expect(racer.position).to eql 2
      end

      it 'must deduct damage before moving' do
        racer = Racer.new
        racer.damage = 1
        racer.roll 1, speed: :NORMAL

        expect(racer.position).to eql 0
      end

      it 'must not move backwards' do
        racer = Racer.new
        racer.damage = 2
        racer.roll 1, speed: :NORMAL

        expect(racer.position).to eql 0
      end
    end

    context 'with SUPER speed' do
      it 'must move position to roll and add 1 damage' do
        racer = Racer.new
        racer.roll 1, speed: :SUPER
        expect(racer.position).to eql 1
        expect(racer.damage).to eql 2

        racer = Racer.new
        racer.roll 2, speed: :SUPER
        expect(racer.position).to eql 2
        expect(racer.damage).to eql 2

        racer = Racer.new
        racer.roll 3, speed: :SUPER
        expect(racer.position).to eql 3
        expect(racer.damage).to eql 2

        racer = Racer.new
        racer.roll 4, speed: :SUPER
        expect(racer.position).to eql 4
        expect(racer.damage).to eql 2

        racer = Racer.new
        racer.roll 5, speed: :SUPER
        expect(racer.position).to eql 5
        expect(racer.damage).to eql 2

        racer = Racer.new
        racer.roll 6, speed: :SUPER
        expect(racer.position).to eql 6
        expect(racer.damage).to eql 2
      end

      it 'must deduct damage before moving' do
        racer = Racer.new
        racer.damage = 1
        racer.roll 1, speed: :SUPER

        expect(racer.position).to eql 0
        expect(racer.damage).to eql 3
      end

      it 'must not move backwards' do
        racer = Racer.new
        racer.damage = 2
        racer.roll 1, speed: :SUPER

        expect(racer.position).to eql 0
        expect(racer.damage).to eql 4
      end
    end
  end
end
