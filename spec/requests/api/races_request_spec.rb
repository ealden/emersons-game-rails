RSpec.describe Api::RacesController, type: :request do
  let(:race) { Race.create }

  before do
    race.update finish_line: 10
  end

  describe 'GET /api/races' do
    it 'must return current race' do
      racer = race.racers.create name: 'Alice'

      get '/api/races'

      expect(response).to have_http_status :ok
      expect(response.json).to eql 'api/races/get_response'.json
    end

    it 'must set allCrashed to true if all racers crashed' do
      racer = race.racers.create name: 'Alice'
      racer.roll 1, speed: :NORMAL
      racer.update damage: Racer::MAX_DAMAGE

      get '/api/races'

      expect(response).to have_http_status :ok
      expect(response.json).to eql 'api/races/get_with_all_racers_crashed_response'.json
    end

    it 'must render even if no racers' do
      get '/api/races'

      expect(response).to have_http_status :ok
      expect(response.json).to eql 'api/races/get_with_no_racers_response'.json
    end
  end

  describe 'POST /api/races/roll' do
    it 'must roll for racer' do
      race.racers.create name: 'Alice'
      race.racers.create name: 'Bob'

      post '/api/races/roll', params: {
        speedType: 'NORMAL',
        roll: 1
      }

      expect(response).to have_http_status :ok

      get '/api/races'

      expect(response.json).to eql 'api/races/get_after_roll_response'.json
    end
  end

  describe 'POST /api/races' do
    it 'must create a new race' do
      post '/api/races', params: {}

      expect(response).to have_http_status :ok
      expect(Race.count).to eql 1
      expect(Race.last).not_to be eql race
    end
  end
end
