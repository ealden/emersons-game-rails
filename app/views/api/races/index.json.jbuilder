json.id @race.id
json.racers @race.racers do |racer|
  json.id       racer.id
  json.name     racer.name
  json.position racer.position
  json.damage   racer.damage
  json.rank     racer.rank
  json.winner   racer.won?
  json.crashed  racer.crashed?
end
json.currentRacer do
  json.id       @race.current_racer.id
  json.name     @race.current_racer.name
  json.position @race.current_racer.position
  json.damage   @race.current_racer.damage
  json.rank     @race.current_racer.rank
  json.winner   @race.current_racer.won?
  json.crashed  @race.current_racer.crashed?
end
if @race.last_roll
  json.lastRoll do
    json.id @race.last_roll.id
    json.racer do
      json.id       @race.last_roll.racer.id
      json.name     @race.last_roll.racer.name
      json.position @race.last_roll.racer.position
      json.damage   @race.last_roll.racer.damage
      json.rank     @race.last_roll.racer.rank
      json.winner   @race.last_roll.racer.won?
      json.crashed  @race.last_roll.racer.crashed?
    end
    json.position     @race.last_roll.position
    json.damage       @race.last_roll.damage
    json.speedType    @race.last_roll.speed
    json.roll         @race.last_roll.roll
    json.move         @race.last_roll.move
    json.newPosition  @race.last_roll.new_position
    json.newDamage    @race.last_roll.new_damage
    json.crashed      @race.last_roll.crashed?
    json.win          @race.last_roll.won?
    json.damaged      @race.last_roll.damaged?
    json.normalSpeed  @race.last_roll.normal_speed?
    json.superSpeed   @race.last_roll.super_speed?
  end
else
  json.lastRoll nil
end
json.finishLine @race.finish_line
json.allCrashed @race.all_crashed?
json.over       @race.over?
