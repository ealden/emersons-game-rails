class Roll < ApplicationRecord
  NO_DAMAGE = 0

  belongs_to :race
  belongs_to :racer

  def damaged?
    self.new_damage.present? and (self.new_damage > NO_DAMAGE)
  end

  def normal_speed?
    :NORMAL == self.speed&.to_sym
  end

  def super_speed?
    :SUPER == self.speed&.to_sym
  end
end
