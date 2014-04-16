simulator = require('../terrarium')

describe 'Environment', ->
  beforeEach ->
    @standard_env = new simulator.Environment
    @custom_env   = new simulator.Environment {tickSpeed: 1500}
    @test_entity  = new simulator.Entity {environment: @custom_env}

  describe 'constructor', ->
    it 'uses defaults', ->
      @standard_env.date.should.eql       0
      @standard_env.tickSpeed.should.eql  2000
      @standard_env.population.should.eql []
    it 'sets unique presets', ->
      @custom_env.date.should.eql       0
      @custom_env.tickSpeed.should.eql  1500
      @custom_env.population.should.eql [@test_entity]

  describe 'start()', ->
    it 'starts the clock', ->
      @standard_env.start()
      @standard_env.timerId.should.be.ok

  describe 'stop()', ->
    it 'stops the clock', ->
      @standard_env.start()
      @standard_env.stop().should.be.ok

  describe 'populationSize()', ->
    it 'tells how many entities there are', ->
      @standard_env.populationSize().should.eql(0)
      @custom_env.populationSize().should.eql(1)

  describe 'reset()', ->
    it 'goes to original state from instantiation', ->
      @custom_env.date = 100
      @custom_env.tickSpeed =  500
      @custom_env.population = ['blahh']
      @custom_env.reset()
      @custom_env.date.should.eql 0
      @custom_env.tickSpeed.should.eql = 1500
      @custom_env.population.should.eql [@test_entity]

  describe 'tick()', ->
    it 'updates entities', ->
      old_age = @test_entity.age
      @custom_env.tick()
      new_age = @test_entity.age
      responded_to_tick = true if old_age < new_age
      responded_to_tick.should.be.true
