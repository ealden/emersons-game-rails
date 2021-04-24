RSpec.describe Api::SettingsController, type: :request do
  describe 'GET /api/settings' do
    it 'must return settings' do
      get '/api/settings'

      expect(response).to have_http_status :ok
      expect(response.json).to eql 'api/settings/get_response'.json
    end
  end
end
