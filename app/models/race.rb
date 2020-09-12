class Race < ApplicationRecord
  has_many :racers, dependent: :destroy
  has_many :rolls,  dependent: :destroy

  def self.new_race
    self.destroy_all

    race = self.create
    race.update finish_line: 10

    race.racers.create name: 'Alice'
    race.racers.create name: 'Bob'
    race.racers.create name: 'Charlie'
    race.racers.create name: 'Dave'

    race
  end

  def roll roll = random_roll, speed:
    self.current_racer.roll roll, speed: speed

    next_racer
  end

  def message
    I18n.t message_key, **message_values
  end

  def last_roll
    self.rolls.last
  end

  def current_racer
    self.racers.find_by rank: self.current_rank
  end

  def all_crashed?
    (not self.racers.empty?) and (not self.racers.map(&:crashed?).include? false)
  end

  def over?
    self.racers.map(&:won?).include?(true) || self.all_crashed?
  end

  private

    def random_roll
      1 + Random.rand(6)
    end

    def next_racer
      next_rank = ((self.current_rank % self.racers.count) + 1)

      self.update current_rank: next_rank
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
      elsif last_roll.damaged? and last_roll.normal_speed?
        :damaged_racer_normal_speed
      elsif last_roll.damaged? and last_roll.super_speed?
        :damaged_racer_super_speed
      else
        :racer_rolled
      end
    end

    def message_values
      {
        current_racer:  current_racer&.name,
        last_racer:     last_roll&.racer&.name,
        last_speed:     last_roll&.speed,
        last_roll:      last_roll&.roll,
        last_move:      last_roll&.move,
        last_damage:    last_roll&.new_damage
      }
    end
end
