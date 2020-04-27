Given 'I am in a race' do
  Race.delete_all

  @race = Race.new_race
  @race.update finish_line: 10

  @racer = @race.current_racer

  @page = RacePage.new
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
  @page.load

  @page.roll roll, speed: @speed
end

When  'I try to view the race' do
  @page.load
end

When  'I choose to start over in a new race' do
  @page.load

  @page.new_race

  @race = Race.last
  @racer = @race.current_racer
end

When  'all racers have crashed!' do
  @page.load

  @page.roll 1, speed: :NORMAL

  Racer.all.each do |racer|
    racer.update damage: Racer::MAX_DAMAGE
  end

  @page.load
end

When  'it\'s over, it\'s over' do
  # No need as browser is closed regardless
end

Then  'I must now be at position {int}' do |new_position|
  expect(@page.position(@racer.id)).to eql new_position
end

Then  'I must now have damage of {int}' do |new_damage|
  expect(@page.damage(@racer.id)).to eql new_damage
end

Then  'I must see the race result: --' do
  expect(@page.position(@racer.id)).not_to eql @race.finish_line
end

Then  'I must see the race result: WIN' do
  expect(@page.position(@racer.id)).to eql @race.finish_line
end

Then  'I must now have a log entry with the following:' do
  @last_roll = @race.last_roll

  expect(@last_roll).not_to be_nil
  expect(@last_roll.racer).to eql @racer
end

Then  'Position: {int}' do |position|
  expect(@last_roll.position).to eql position
end

Then  'Damage: {int}' do |damage|
  expect(@last_roll.damage).to eql damage
end

Then  'Speed: {string}' do |speed|
  expect(@last_roll.speed).to eql speed
end

Then  'Roll: {int}' do |roll|
  expect(@last_roll.roll).to eql roll
end

Then  'Move: {int}' do |move|
  expect(@last_roll.move).to eql move
end

Then  'New Position: {int}' do |new_position|
  expect(@last_roll.new_position).to eql new_position
end

Then  'New Damage: {int}' do |new_damage|
  expect(@last_roll.new_damage).to eql new_damage
end

Then  'Crashed: "YES"' do
  expect(@last_roll).to be_crashed
end

Then  'Crashed: "NO"' do
  expect(@last_roll).not_to be_crashed
end

Then  'Win: "YES"' do
  expect(@last_roll).to be_won
end

Then  'Win: "NO"' do
  expect(@last_roll).not_to be_won
end

Then  'I must see the message: {string}' do |message|
  expect(@page.message).to eql message
end

Then  'our race must be over!' do
  expect(@page).to be_over
end
