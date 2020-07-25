RSpec.describe Race, type: :model do
  let(:race) { Race.create }

  describe :last_roll do
    subject { race.last_roll }

    context 'when no rolls yet' do
      it { is_expected.to be nil }
    end

    context 'when racers roll' do
      it 'is expected to return last roll' do
        racer = race.racers.create name: 'Racer 1'

        racer.roll(1, speed: :NORMAL)
        racer.roll(2, speed: :NORMAL)

        expect(subject).to eql race.rolls.last
      end
    end
  end

  describe :message do
    subject { race.message }

    context 'when no racers have joined' do
      it { is_expected.to eql 'Racers to starting line!' }
    end

    context 'when racers have joined' do
      before do
        race.racers.create name: 'Racer 1'
      end

      it { is_expected.to eql 'Time to RACE!  Racer 1 rolls first!' }
    end
  end

  describe :all_crashed? do
    subject { race.all_crashed? }

    context 'when all racers crashed' do
      before do
        race.racers.create name: 'Racer 1', damage: Racer::MAX_DAMAGE
        race.racers.create name: 'Racer 2', damage: Racer::MAX_DAMAGE
        race.racers.create name: 'Racer 3', damage: Racer::MAX_DAMAGE
      end

      it { is_expected.to be true }
    end

    context 'when no racers crashed' do
      before do
        race.racers.create name: 'Racer 1'
        race.racers.create name: 'Racer 2'
        race.racers.create name: 'Racer 3'
      end

      it { is_expected.to be false }
    end

    context 'when some racers crashed' do
      before do
        race.racers.create name: 'Racer 1', damage: Racer::MAX_DAMAGE
        race.racers.create name: 'Racer 2'
        race.racers.create name: 'Racer 3', damage: Racer::MAX_DAMAGE
      end

      it { is_expected.to be false }
    end

    context 'when no racers' do
      it { is_expected.to be false }
    end
  end

  describe :current_rank do
    subject { race.current_rank }

    context 'when no racers' do
      it { is_expected.to be nil }
    end

    context 'when first racer joins race' do
      it 'must equal 1' do
        race.racers.create name: 'Racer 1'

        expect(subject).to eql 1
      end
    end

    context 'when many racers join race' do
      it 'must equal 1' do
        race.racers.create name: 'Racer 1'
        race.racers.create name: 'Racer 2'

        expect(subject).to eql 1
      end
    end
  end

  describe :roll do
    it 'must move current_rank to next racer after roll' do
      racer   = race.racers.create name: 'Racer 1'
      racer2  = race.racers.create name: 'Racer 2'
      racer3  = race.racers.create name: 'Racer 3'
      racer4  = race.racers.create name: 'Racer 4'

      race.roll 1, speed: :NORMAL

      expect(race.last_roll).not_to be_nil
      expect(race.current_rank).to eql racer2.id
      expect(race.current_racer).to eql racer2
    end

    it 'must move current_rank to first racer after last racer' do
      racer   = race.racers.create name: 'Racer 1'
      racer2  = race.racers.create name: 'Racer 2'
      racer3  = race.racers.create name: 'Racer 3'
      racer4  = race.racers.create name: 'Racer 4'

      race.update current_rank: racer4.rank

      race.roll 1, speed: :NORMAL

      expect(race.last_roll).not_to be_nil
      expect(race.current_rank).to eql racer.id
      expect(race.current_racer).to eql racer
    end
  end

  describe :over? do
    subject { race.over? }

    before do
      race.update finish_line: 10
    end

    context 'when no racer has crossed the finish line' do
      before do
        race.racers.create name: 'Racer 1'
        race.racers.create name: 'Racer 2'
        race.racers.create name: 'Racer 3'
      end

      it { is_expected.to be false }
    end

    context 'when one racer has crossed the finish line' do
      before do
        race.racers.create name: 'Racer 1'
        race.racers.create name: 'Racer 2', position: race.finish_line
        race.racers.create name: 'Racer 3'
      end

      it { is_expected.to be true }
    end

    context 'when all racers crashed' do
      before do
        race.racers.create name: 'Racer 1', damage: Racer::MAX_DAMAGE
        race.racers.create name: 'Racer 2', damage: Racer::MAX_DAMAGE
        race.racers.create name: 'Racer 3', damage: Racer::MAX_DAMAGE
      end

      it { is_expected.to be true }
    end

    context 'when no racers' do
      it { is_expected.to be false }
    end
  end
end
