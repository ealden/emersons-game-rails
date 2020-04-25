json.id @race.id
json.racers @race.racers do |racer|
  json.id       racer.id
  json.name     racer.name
  json.position racer.position
  json.damage   racer.damage
  json.rank     1
  json.winner   racer.won?
  json.crashed  racer.crashed?
end
json.currentRacer do
  json.id       @current_racer.id
  json.name     @current_racer.name
  json.position @current_racer.position
  json.damage   @current_racer.damage
  json.rank     1
  json.winner   @current_racer.won?
  json.crashed  @current_racer.crashed?
end
json.lastRoll   nil
json.finishLine @race.finish_line
json.allCrashed false
json.over       false
