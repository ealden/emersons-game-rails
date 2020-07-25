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

  def roll roll = (1 + Random.rand(6)), speed:
    self.current_racer.roll roll, speed: speed

    next_racer
  end

  def message
    if racers.empty?
      'Racers to starting line!'
    elsif last_roll.nil?
      "Time to RACE!  #{current_racer.name} rolls first!"
    elsif all_crashed?
      'All racers CRASHED!!!  This race is over!'
    elsif over?
      "#{last_roll.racer.name} wins the race!  Congratulations!!!"
    else
      message = "#{last_roll.racer.name} chose #{last_roll.speed} speed, " \
        + "and rolled #{last_roll.roll} and moved #{last_roll.move}."

      if last_roll.crashed?
        message += "  #{last_roll.racer.name} CRASHED!!!"
      elsif last_roll.damaged? and last_roll.normal_speed?
        message += "  #{last_roll.racer.name} has #{last_roll.new_damage} damage."
      elsif last_roll.damaged? and last_roll.super_speed?
        message += "  #{last_roll.racer.name} now has #{last_roll.new_damage} damage."
      end

      message += "  #{current_racer.name} rolls next!"

      message
    end
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

    def next_racer
      next_rank = ((self.current_rank % self.racers.count) + 1)

      self.update current_rank: next_rank
    end

    def roll_message
    end
end
