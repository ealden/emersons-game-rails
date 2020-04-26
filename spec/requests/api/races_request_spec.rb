require 'rails_helper'

RSpec.describe Api::RacesController, type: :request do
  describe 'GET /api/races' do
    it 'must return current race' do
      race = Race.create
      race.update finish_line: 10

      racer = race.racers.create name: 'Alice'

      expected_response = {
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
      expect(response.body).to eql expected_response.to_json
    end

    it 'must be allCrashed if all racers crashed' do
      race = Race.create
      race.update finish_line: 10

      racer = race.racers.create name: 'Alice'
      racer.roll 1, speed: :NORMAL
      racer.update damage: Racer::MAX_DAMAGE

      expected_response = {
        id: 1,
        racers: [
          {
            id: 1,
            name: 'Alice',
            position: 1,
            damage: 6,
            rank: 1,
            winner: false,
            crashed: true
          }
        ],
        currentRacer: {
          id: 1,
          name: 'Alice',
          position: 1,
          damage: 6,
          rank: 1,
          winner: false,
          crashed: true
        },
        lastRoll: {
          id: 1,
          racer: {
            id: 1,
            name: 'Alice',
            position: 1,
            damage: 6,
            rank: 1,
            winner: false,
            crashed: true
          },
          position: 0,
          damage: 0,
          speedType: 'NORMAL',
          roll: 1,
          move: 1,
          newPosition: 1,
          newDamage: 0,
          crashed: false,
          win: false,
          damaged: false,
          normalSpeed: true,
          superSpeed: false
        },
        finishLine: 10,
        allCrashed: true,
        over: true
      }

      get '/api/races'

      expect(response).to have_http_status :ok
      expect(response.body).to eql expected_response.to_json
    end
  end

  describe 'GET /api/races/settings' do
    it 'must return race settings' do
      expected_response = {
        testMode: true
      }

      get '/api/races/settings'

      expect(response).to have_http_status :ok
      expect(response.body).to eql expected_response.to_json
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

  describe 'POST /api/races/new' do
    it 'must create a new race' do
      race = Race.create
      racer = race.racers.create name: 'Alice'

      post '/api/races/new', params: {}

      expect(response).to have_http_status :ok
      expect(Race.count).to eql 1
      expect(Race.last).not_to be eql race
    end
  end
end
