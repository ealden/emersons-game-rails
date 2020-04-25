Given 'I am in a race' do
  @race = Race.create

  @racer = @race.racers.create name: 'Alice'
end

Given 'I am at position {int}' do |position|
  @racer.update position: position
end

Given 'I have damage of {int}' do |damage|
  @racer.update damage: damage
end

Given 'I see the finish line at position {int}' do |finish_line|
  @race.update finish_line: finish_line
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

Then  'I must see the race result: --' do
  expect(@racer).not_to be_won
end

Then  'I must see the race result: WIN' do
  expect(@racer).to be_won
end

Then  'I must now have a log entry with the following:' do
  expect(@race.last_roll).not_to be_nil
  expect(@race.last_roll.racer).to eql @racer
end
