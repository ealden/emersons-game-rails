require 'rails_helper'

RSpec.describe Api::RacesController, type: :request do
  describe 'GET /api/races' do
    it 'must return current race' do
      race = Race.create
      race.update finish_line: 10

      racer = race.racers.create name: 'Alice'

      expected_json = {
        id: 1,
        racers: [
          {
            id: 1,
            name: 'Alice',
            position: 0,
            damage: 0,
            rank: 1,
            winner: false,
            crashed: false
          }
        ],
        currentRacer: {
          id: 1,
          name: 'Alice',
          position: 0,
          damage: 0,
          rank: 1,
          winner: false,
          crashed: false
        },
        lastRoll: nil,
        finishLine: 10,
        allCrashed: false,
        over: false
      }

      get '/api/races'

      expect(response).to have_http_status :ok
      expect(response.body).to eql expected_json.to_json
    end
  end

  describe 'GET /api/races/settings' do
    it 'must return race settings' do
      expected_json = {
        testMode: true
      }

      get '/api/races/settings'

      expect(response).to have_http_status :ok
      expect(response.body).to eql expected_json.to_json
    end
  end

  describe 'POST /api/races/roll' do
    it 'must roll for racer' do
      race = Race.create
      racer = race.racers.create name: 'Alice'

      post '/api/races/roll', params: {
        speedType: 'NORMAL',
        roll: 1
      }

      expect(response).to have_http_status :ok
      expect(race.last_roll).to have_attributes roll: 1, speed: 'NORMAL'
    end
  end
end
