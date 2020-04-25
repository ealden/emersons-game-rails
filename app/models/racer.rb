class Racer < ApplicationRecord
  def roll roll, speed: nil
    case speed
    when :NORMAL
      self.position += ((roll.odd? ? 1 : 2) - self.damage)
    when :SUPER
      self.position += (roll - self.damage)
      self.damage += 2
    end
  end
end
