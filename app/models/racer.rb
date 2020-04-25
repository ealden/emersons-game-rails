class Racer < ApplicationRecord
  has_many :rolls

  belongs_to :race

  def roll roll, speed: nil
    case speed
    when :NORMAL
      move = ((roll.odd? ? 1 : 2) - self.damage)
    when :SUPER
      move = (roll - self.damage)
      self.damage += 2
    end

    self.position += [move, 0].max
    self.position = [self.position, self.race.finish_line].min

    self.rolls.create race:         self.race,
                      position:     self.position_was,
                      damage:       self.damage_was,
                      speed:        speed,
                      roll: 0,
                      move: 0,
                      new_position: 0,
                      new_damage: 0
  end

  def won?
    self.position >= self.race.finish_line
  end
end
