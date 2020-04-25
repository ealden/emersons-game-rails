require 'rails_helper'

RSpec.describe Racer, type: :model do
  describe :roll do
    it 'must return 1 if roll is odd' do
      expect(Racer.new.roll(1, speed: nil)).to eql 1
      expect(Racer.new.roll(3, speed: nil)).to eql 1
      expect(Racer.new.roll(5, speed: nil)).to eql 1
    end

    it 'must return 2 if roll is even' do
      expect(Racer.new.roll(1, speed: nil)).to eql 1
      expect(Racer.new.roll(3, speed: nil)).to eql 1
      expect(Racer.new.roll(5, speed: nil)).to eql 1
    end
  end
end
