Given 'I am in a race' do
  @race = Race.new_race

  @page = RacePage.new

  @page.load
end

Given 'I am at position {int}' do |position|
  @race.current_racer.update position: position
end

Given 'I have damage of {int}' do |damage|
  @race.current_racer.update damage: damage
end

Given 'I see the finish line at position {int}' do |finish_line|
  @race.update finish_line: finish_line
end

When 'I choose {string} speed' do |speed|
  @speed = speed.to_sym
end

When 'I roll a {int}' do |roll|
  @page.roll roll, speed: @speed
end

When 'I choose to start over in a new race' do
  @page.new_race

  @race = Race.last
end

When 'all racers have crashed!' do
  @page.roll 1, speed: :NORMAL

  Racer.update_all damage: Racer::MAX_DAMAGE

  @page.load
end

Then 'I must now be at position {int}' do |new_position|
  expect(@page.position_of(@race.current_racer)).to eql new_position
end

Then 'I must now have damage of {int}' do |new_damage|
  expect(@page.damage_of(@race.current_racer)).to eql new_damage
end

Then 'I must see the race result: --' do
  expect(@page.position_of(@race.current_racer)).not_to eql @race.finish_line
end

Then 'I must see the race result: WIN' do
  expect(@page.position_of(@race.current_racer)).to eql @race.finish_line
end

Then 'I must now have a log entry with the following:' do
  expect(@race.last_roll).not_to be_nil
  expect(@race.last_roll.racer).to eql @race.current_racer
end

Then 'Position: {int}' do |position|
  expect(@race.last_roll.position).to eql position
end

Then 'Damage: {int}' do |damage|
  expect(@race.last_roll.damage).to eql damage
end

Then 'Speed: {string}' do |speed|
  expect(@race.last_roll.speed).to eql speed
end

Then 'Roll: {int}' do |roll|
  expect(@race.last_roll.roll).to eql roll
end

Then 'Move: {int}' do |move|
  expect(@race.last_roll.move).to eql move
end

Then 'New Position: {int}' do |new_position|
  expect(@race.last_roll.new_position).to eql new_position
end

Then 'New Damage: {int}' do |new_damage|
  expect(@race.last_roll.new_damage).to eql new_damage
end

Then 'Crashed: YES' do
  expect(@race.last_roll).to be_crashed
end

Then 'Crashed: NO' do
  expect(@race.last_roll).not_to be_crashed
end

Then 'Win: YES' do
  expect(@race.last_roll).to be_won
end

Then 'Win: NO' do
  expect(@race.last_roll).not_to be_won
end

Then 'I must see the message: {string}' do |message|
  expect(@page.message).to eql message
end

Then 'our race must be over!' do
  expect(@page).to be_over
end
