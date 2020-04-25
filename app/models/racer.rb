class Racer < ApplicationRecord
  def roll roll, speed: nil
    case speed
    when :NORMAL
      move = ((roll.odd? ? 1 : 2) - self.damage)
    when :SUPER
      move = (roll - self.damage)
      self.damage += 2
    end

    self.position += [move, 0].max
  end
end
