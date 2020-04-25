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

Given 'I see the finish line at position {int}' do |finish_line|
  @race.finish_line = finish_line
end
