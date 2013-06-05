simulator = require('../terrarium')

describe 'Environment', ->
  standard_env = new simulator.Environment
  custom_env   = new simulator.Environment {tickSpeed: 1500}
  test_entity  = new simulator.Entity {environment: custom_env}

  describe 'constructor', ->
    it 'exists', ->
      standard_env.should.be.ok

    it 'uses defaults', ->
      standard_env.date.should.eql       0
      standard_env.tickSpeed.should.eql  2000
      standard_env.population.should.eql []

    it 'sets unique presets', ->
      custom_env.date.should.eql       0
      custom_env.tickSpeed.should.eql  1500
      custom_env.population.should.eql [test_entity]

  describe 'start()', ->
    beforeEach ->
      standard_env.start()

    it 'starts the clock', ->
      standard_env.timerId.should.be.ok

    it 'stops the clock', ->
      #refactor
      standard_env.stop().should.be.ok

  describe 'populationSize', ->
    it 'tells how many entities there are', ->
      standard_env.populationSize().should.eql(0)
      custom_env.populationSize().should.eql(1)
