Race.delete_all

race = Race.create
race.update finish_line: 10

race.racers.create name: 'Alice'
race.racers.create name: 'Bob'
race.racers.create name: 'Charlie'
race.racers.create name: 'Dave'
