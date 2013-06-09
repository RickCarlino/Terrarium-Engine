#Interesting strategy guide:
# http://flowingdata.com/2010/07/30/how-to-win-rock-paper-scissors-every-time/
simulator = require '../terrarium'

class Player extends simulator.Entity
  throwRandom: ->
    Math.floor(Math.random()*3)

  throwRock: ->
    return 0

class Game extends simulator.Environment
  start: ->
    if @populationSize() isnt 2
      return console.log 'Incorrect number of players. RPS is a 2 player game. Aborting.'
    super
  afterTick: (results)->
    if @date > 999
      @stop()
      return console.log """
      Results after #{@date} rounds:
      Player1 (#{@population[0].name}): #{@population[0].score}
      Player2 (#{@population[1].name}): #{@population[1].score}
      """
    @determineWinner(@results[0], @results[1])
  determineWinner: (a,b) ->
    if a.hand is b.hand
      console.log "Tie!!!"
    else if a.hand is 0 and b.hand is 1
      console.log "B wins"
      ++b.player.score
    else if a.hand is 0 and b.hand is 2
      console.log "A wins"
      ++a.player.score
    else if a.hand is 1 and b.hand is 0
      console.log "A wins"
      ++a.player.score
    else if a.hand is 1 and b.hand is 2
      console.log "B wins"
      ++b.player.score
    else if a.hand is 2 and b.hand is 0
      console.log "B wins"
      ++b.player.score
    else if a.hand is 2 and b.hand is 1
      console.log "A wins"
      ++a.player.score
  #For reference...
  gameMap:{
      '0':'rock',
      '1':'paper',
      '2':'scissors'
       }


game = new Game {tickSpeed: 1}

avalancheStrategy = new Player {environment: game, name: "Rock Only"}
avalancheStrategy.onTick = ->
  return {hand: @throwRock(), player: @}
avalancheStrategy.score = 0

randomStrategy    = new Player {environment: game, name: "Random"}
randomStrategy.onTick = ->
  return {hand: @throwRandom(), player: @}
randomStrategy.score = 0

game.start()