Given 'I am in a race' do
  @race = Race.new
  @racer = Racer.new
end

Given 'I am at position {int}' do |position|
  @racer.position = position
end

Given 'I have damage of {int}' do |damage|
  @racer.damage = damage
end
