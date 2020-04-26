class Roll < ApplicationRecord
  NO_DAMAGE = 0

  belongs_to :race
  belongs_to :racer

  def damaged?
    self.new_damage.present? and (self.new_damage > NO_DAMAGE)
  end

  def normal_speed?
    self.speed == :NORMAL.to_s
  end

  def super_speed?
    self.speed == :SUPER.to_s
  end
end
