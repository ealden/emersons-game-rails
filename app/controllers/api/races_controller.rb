class Api::RacesController < ApiController
  def settings
    render json: {
      testMode: true
    }
  end
end
