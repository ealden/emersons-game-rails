class Api::RacesController < ApiController
  def index
    @race = Race.last
  end

  def roll
    race = Race.last

    roll  = params[:roll].to_i
    speed = params[:speedType].to_sym

    if Rails.env.test?
      race.roll roll, speed: speed
    else
      race.roll speed: speed
    end

    head :ok
  end

  def new_race
    Race.new_race

    head :ok
  end
end
