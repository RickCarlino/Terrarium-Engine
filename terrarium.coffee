#Terrarium Engine
#=================
#An event simulation engine written by Rick Carlino
#--------------------------------------------------
####Licensed under the MIT license.


#An environment is a container that holds all entities involved in the simulation.
class @Environment
  #The constructor expects you to pass it an object that contains all of its options. It will go with presets if you do not specify anything
  constructor: (options = {}) ->
    #The population is a collection of entities within the current environment. All objects in the Array should respond to onTick().
    @population = options.population ? []
    #Speed that the tick method will fire off at, in millisecs.
    @tickSpeed = options.tickSpeed ? 2000
    #A reference point that is incremented on every tick()
    @date = 0
    #store this so reset() has a reference point of what the original state was.
    @originalOptions = {@population, @tickSpeed}
    #return 'this'
    @
  tick: =>
    console.log "Simulator is running. The in-simulation date is: #{@date}."
    for entity in @population
      console.log "Ticking #{entity.name}"
      #Gracefully handle objects that don't respond to onTick()
      try
        entity.onTick()
      catch e
        null
    #increment the date by 1 after the tick is completed
    ++@date
  start: =>
    delete @timerId
    #TimerId is stored so that we can reference it to pause or stop later
    @timerId = setInterval =>
      @tick()
    , @tickSpeed
    #return true if it stored the timerId, false otherwise
    return true if @timerId >= 0
    false
  stop: ->
    clearInterval(@timerId)
    true
  reset: ->
    @stop()
    @population = @originalOptions.population
    #Speed that the tick method will fire off at, in millisecs.
    @tickSpeed = @originalOptions.tickSpeed
    #A reference point that is incremented on every tick()
    @date = 0
    true
  populationSize: ->
    @population.length

#An Entity is any thing that interacts with an environment.
class @Entity
  #Ensure that an environment has been spcified for the entity in the options parameter..
  constructor: (options) ->
    try
      @environment = options.environment
      @environment.population.push @
      @age = 0
      console.log "@environment.populationSize()...#{@environment.population}"
      @name = options.name ? "Entity#{@environment.populationSize() + 1}"
    catch e
      console.error 'Entities may not exist outside of an  environment. You must specify the environment on instantiation.'

  onTick: =>
    #Increments the entities age by one on every tick. Make sure you call super if you override this in derived classes.
    ++@age

  #Ensure that the Entity is removed from the population when no longer needed. Prevents the tick() event from calling old Entities.
  destroy: ->
    destroyThisIndex = @environment.population.indexOf(@)
    @environment.population.pop(destroyThisIndex)
    null
