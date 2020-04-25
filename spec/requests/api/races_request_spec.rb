require 'rails_helper'

RSpec.describe Api::RacesController, type: :request do
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
