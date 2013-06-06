simulator = require('../terrarium')

describe 'Entity', ->
  beforeEach ->
    @standard_env = new simulator.Environment
    @test_entity  = new simulator.Entity {environment: @standard_env}

  describe 'constructor', ->
    it 'uses defaults', ->
      @test_entity.age.should == 0
      @test_entity.name.should == "Entity#{@test_entity.environment.populationSize()}"
    it 'throws exceptions for orphan entities', ->
      #lol
      -> new simulator.Entity should.throw 'Entities may not exist outside of an  environment. You must specify the environment on instantiation.'

  describe 'onTick()', ->
    it 'increments object age onTick', ->
      old_age = @test_entity.age
      @test_entity.onTick()
      new_age = @test_entity.age
      is_older= old_age < new_age
      is_older.should.be.true

  describe 'destroy()', ->
    it 'implodes', ->
      old_pop      = @standard_env.populationSize()
      @test_entity.destroy()
      new_pop      = @standard_env.populationSize()
      got_smaller  = old_pop > new_pop
      got_smaller.should.be.true
      @test_entity.should.not.be