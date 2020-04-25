require 'rails_helper'

RSpec.describe Api::RacesController, type: :request do
  it 'returns race settings' do
    expected_json = {
      testMode: true
    }

    get '/api/races/settings'

    expect(response).to have_http_status :ok
    expect(response.body).to eql expected_json.to_json
  end
end
