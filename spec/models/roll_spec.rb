RSpec.describe Roll, type: :model do
  let(:roll) { Roll.new }

  describe :damaged? do
    subject { roll.damaged? }

    before do
      roll.new_damage = new_damage
    end

    context 'when no new damage' do
      let(:new_damage) { 0 }

      it { is_expected.to be false }
    end

    context 'when at least 1 new damage' do
      let(:new_damage) { 1 }

      it { is_expected.to be true }
    end
  end

  describe :normal_speed? do
    subject { roll.normal_speed? }

    before do
      roll.speed = speed.to_s
    end

    context 'when NORMAL speed' do
      let(:speed) { :NORMAL }

      it { is_expected.to be true }
    end

    context 'when SUPER speed' do
      let(:speed) { :SUPER }

      it { is_expected.to be false }
    end
  end

  describe :super_speed? do
    subject { roll.super_speed? }

    before do
      roll.speed = speed.to_s
    end

    context 'when SUPER speed' do
      let(:speed) { :SUPER }

      it { is_expected.to be true }
    end

    context 'when NORMAL speed' do
      let(:speed) { :NORMAL }

      it { is_expected.to be false }
    end
  end
end
