class Api::SettingsController < ApiController
  def index
    @test_mode = Rails.env.test?
  end
end
