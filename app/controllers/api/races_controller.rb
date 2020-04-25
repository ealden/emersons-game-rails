class Api::RacesController < ApiController
  def settings
    settings = {
      testMode: Rails.env.test?
    }

    render json: settings
  end

  def roll
    race = Race.last

    roll  = params[:roll].to_i
    speed = params[:speedType].to_sym

    race.racers.first.roll roll, speed: speed

    head :ok
  end
end
