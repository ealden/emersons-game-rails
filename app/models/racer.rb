class Racer < ApplicationRecord
  MAX_DAMAGE = 6

  NORMAL_DAMAGE = 0
  SUPER_DAMAGE  = 2

  NORMAL_MOVE_ODD   = 1
  NORMAL_MOVE_EVEN  = 2

  NO_MOVE = 0

  before_create :set_rank
  after_create  :set_race_current_rank

  has_many :rolls

  belongs_to :race

  def roll roll, speed: nil
    move, damage = calculate roll, speed: speed

    self.position += move
    self.damage += damage

    log roll, move, speed

    save
  end

  def position
    [self[:position], self.race.finish_line].min
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
        move = ((roll > 0) ? (roll.odd? ? NORMAL_MOVE_ODD : NORMAL_MOVE_EVEN) : NO_MOVE)
        damage = NORMAL_DAMAGE
      when :SUPER
        move = roll
        damage = SUPER_DAMAGE
      end

      move = [(move - self.damage), NO_MOVE].max

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

    def set_rank
      self.rank = Racer.count + 1
    end

    def set_race_current_rank
      self.race.update current_rank: self.rank unless self.race.current_rank
    end
end
