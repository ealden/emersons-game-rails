class Racer < ApplicationRecord
  MAX_DAMAGE = 6

  has_many :rolls

  belongs_to :race

  def roll roll, speed: nil
    move, damage = calculate roll, speed: speed

    move = [(move - self.damage), 0].max

    self.position += move
    self.damage += damage

    self.position = [self.position, self.race.finish_line].min

    log roll, move, speed

    save
  end

  def won?
    self.position >= self.race.finish_line
  end

  def crashed?
    self.damage >= MAX_DAMAGE
  end

  private

    def calculate roll, speed:
      case speed
      when :NORMAL
        move = (roll.odd? ? 1 : 2)
        damage = 0
      when :SUPER
        move = roll
        damage = 2
      end

      [move, damage]
    end

    def log roll, move, speed
      self.rolls.create race:         self.race,
                        position:     self.position_was,
                        damage:       self.damage_was,
                        speed:        speed,
                        roll:         roll,
                        move:         move,
                        new_position: self.position,
                        new_damage:   self.damage,
                        crashed:      self.crashed?,
                        won:          self.won?
    end
end
