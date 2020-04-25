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
  end

  def won?
    self.position >= self.race.finish_line
  end
end
