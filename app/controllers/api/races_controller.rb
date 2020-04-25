class Api::RacesController < ApiController
  def index
    @race = Race.last
    @current_racer = @race.racers.last
  end

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
