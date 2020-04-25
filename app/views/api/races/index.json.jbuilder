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
json.lastRoll   nil
json.finishLine @race.finish_line
json.allCrashed false
json.over       false
