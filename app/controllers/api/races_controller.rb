class Api::RacesController < ApiController
  def settings
    settings = {
      testMode: Rails.env.test?
    }

    render json: settings
  end
end
