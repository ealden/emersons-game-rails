class Race < ApplicationRecord
  has_many :racers, dependent: :destroy
  has_many :rolls,  dependent: :destroy

  def self.new_race
    destroy_all

    race = create
    race.update finish_line: 10

    race.racers.create name: 'Alice'
    race.racers.create name: 'Bob'
    race.racers.create name: 'Charlie'
    race.racers.create name: 'Dave'

    race
  end

  def roll roll = random_roll, speed:
    current_racer.roll roll, speed: speed

    next_racer
  end

  def message
    I18n.t message_key, **message_values
  end

  def last_roll
    rolls.last
  end

  def current_racer
    racers.find_by rank: current_rank
  end

  def all_crashed?
    !racers.empty? and (!racers.map(&:crashed?).include? false)
  end

  def over?
    racers.map(&:won?).include?(true) or all_crashed?
  end

  private

  def random_roll
    Random.rand(1..6)
  end

  def next_racer
    next_rank = ((current_rank % racers.count) + 1)

    update current_rank: next_rank
  end

  def message_key
    if racers.empty?
      :no_racers
    elsif last_roll.nil?
      :not_started
    elsif all_crashed?
      :all_crashed
    elsif over?
      :race_over
    elsif last_roll.crashed?
      :racer_crashed
    elsif last_roll.damaged? && last_roll.normal_speed?
      :damaged_racer_normal_speed
    elsif last_roll.damaged? && last_roll.super_speed?
      :damaged_racer_super_speed
    else
      :racer_rolled
    end
  end

  def message_values
    {
      current_racer: current_racer&.name,
      last_racer: last_roll&.racer&.name,
      last_speed: last_roll&.speed,
      last_roll: last_roll&.roll,
      last_move: last_roll&.move,
      last_damage: last_roll&.new_damage
    }
  end
end
