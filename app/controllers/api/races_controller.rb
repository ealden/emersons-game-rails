class Api::RacesController < ApiController
  def index
    @race = Race.last
  end

  def settings
    @test_mode = Rails.env.test?
  end

  def roll
    race = Race.last

    roll  = params[:roll].to_i
    speed = params[:speedType].to_sym

    race.roll roll, speed: speed

    head :ok
  end

  def new_race
    Race.new_race

    head :ok
  end
end
