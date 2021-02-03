class Roll < ApplicationRecord
  NO_DAMAGE = 0

  belongs_to :race
  belongs_to :racer

  def damaged?
    new_damage.present? and (new_damage > NO_DAMAGE)
  end

  def normal_speed?
    :NORMAL == speed&.to_sym
  end

  def super_speed?
    :SUPER == speed&.to_sym
  end
end
