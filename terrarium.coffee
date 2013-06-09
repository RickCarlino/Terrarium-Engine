#Terrarium
#=========
#A simple simulation engine
#--------------------------
#### (c) 2013, Rick Carlino. Licensed under the MIT license.
#An environment is a container that holds all entities involved in the simulation.
class @Environment
  #The constructor expects you to pass it an object that contains all of its options. Uses presets if not specified.
  constructor: (options = {}) ->
    #The population is a collection of entities within the current environment. All objects in the Array should respond to onTick().
    @population = options.population ? []
    #Speed that the tick method will fire off at, in milliseconds.
    @tickSpeed = options.tickSpeed ? 2000
    #A reference point that is incremented on every tick().
    @date = 0
    #store current state so that reset() has a reference point of what the constructors parameters were.
    @originalOptions = {@population, @tickSpeed}
    #return 'this'
    @
  beforeTick: (results) ->
    #This is a stub callback. Override it in your implementation. Gets called before tick. Last ticks results get passed to it.
    null
  afterTick: (results) ->
    #This is a stub callback . Override it in your implementation.
    null
  #The tick event is called by the simulation timer once per iteration.
  tick: =>
    #clear out the results from last tick
    @beforeTick(@results) if @results
    @results = []
    for entity in @population
      try
        #notify each entity that they have been activated for this tick
        #onTick() should fire off all time-based events for entities via custom logic
        #onTick can also optionally have a return value, which will be saved into @results for analysis (if you implement such functionality)
        #If you want to log the results of your onTick() call, make sure you add a return value.
        result = entity.onTick()
        @results.push result
      catch e
        #Gracefully handle objects that don't respond to onTick()
        null
    #increment the date by 1 after the tick is completed
    ++@date
    @afterTick(@results) if @results
  start: =>
    #clear the timerId if there was one set already.
    delete @timerId if @timerId
    #TimerId is stored so that we can reference it to pause or stop later
    @timerId = setInterval =>
      @tick()
    , @tickSpeed
    #return true if it stored the timerId, false otherwise
    return true if @timerId >= 0
    false
  stop: ->
    #halts execution of the simulation. Does not alter state of environment.
    clearInterval(@timerId)
    true
  reset: ->
    #Stops the simulation and brings things back to the way they were on instantiation
    @stop()
    @population = @originalOptions.population
    @tickSpeed = @originalOptions.tickSpeed
    @date = 0
    true
  populationSize: ->
    #dynamically indicates how many entities exist
    @population.length

#An Entity is anything that interacts with an environment.
class @Entity
  constructor: (options = {}) ->
    #Ensure that an environment has been spcified for the entity in the options parameter..
    try
      @environment = options.environment
    catch e
      console.error 'Entities may not exist outside of an  environment. You must specify the environment on instantiation.'
      delete @
    #Ensure that the Entity actually gets put into said Environment.
    try
      @environment.population.push @
    catch e
      console.error 'Was unable to push entity into environment.'
      delete @
    #Set the entities name and age, which are used for reference purposes.
    @age     = options.age ? 0
    @name    = options.name ? "Entity#{@environment.populationSize() + 1}"
    #Save these options to a variable so that I can implement a reset() method. Not yet implemented. Pull requests welcome ;-)
    @options = {@age, @name, @environment}

  onTick: =>
    #Increments the entities age by one on every tick. Make sure you call super if you override this in a derived classes.
    ++@age
  #Ensure that the Entity is removed from the population and deleted when no longer needed. Prevents the tick() event from calling old Entities.
  destroy: ->
    destroyThisIndex = @environment.population.indexOf(@)
    @environment.population.pop(destroyThisIndex)
    delete @