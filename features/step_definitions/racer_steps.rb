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

When  'I choose {string} speed' do |speed|
  @speed = speed.to_sym
end

When  'I roll a {int}' do |roll|
  @racer.roll roll, speed: @speed
end

Then  'I must now be at position {int}' do |new_position|
  expect(@racer.position).to eql new_position
end

Then  'I must now have damage of {int}' do |new_damage|
  expect(@racer.damage).to eql new_damage
end
