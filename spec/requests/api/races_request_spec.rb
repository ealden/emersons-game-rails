require 'rails_helper'

RSpec.describe Api::RacesController, type: :request do
  it 'returns race settings' do
    get '/api/races/settings'

    expect(response).to have_http_status :ok
  end
end
