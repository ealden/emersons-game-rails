class Racer < ApplicationRecord
  MAX_DAMAGE = 6

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

    move = [move, 0].max

    self.position += move
    self.position = [self.position, self.race.finish_line].min

    self.rolls.create race:         self.race,
                      position:     self.position_was,
                      damage:       self.damage_was,
                      speed:        speed,
                      roll:         roll,
                      move:         move,
                      new_position: self.position,
                      new_damage:   self.damage

    save
  end

  def won?
    self.position >= self.race.finish_line
  end

  def crashed?
    self.damage >= MAX_DAMAGE
  end
end
