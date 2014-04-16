(function() {
  var simulator;

  simulator = require('../terrarium');

  describe('Environment', function() {
    beforeEach(function() {
      this.standard_env = new simulator.Environment;
      this.custom_env = new simulator.Environment({
        tickSpeed: 1500
      });
      return this.test_entity = new simulator.Entity({
        environment: this.custom_env
      });
    });
    describe('constructor', function() {
      it('uses defaults', function() {
        this.standard_env.date.should.eql(0);
        this.standard_env.tickSpeed.should.eql(2000);
        return this.standard_env.population.should.eql([]);
      });
      return it('sets unique presets', function() {
        this.custom_env.date.should.eql(0);
        this.custom_env.tickSpeed.should.eql(1500);
        return this.custom_env.population.should.eql([this.test_entity]);
      });
    });
    describe('start()', function() {
      return it('starts the clock', function() {
        this.standard_env.start();
        return this.standard_env.timerId.should.be.ok;
      });
    });
    describe('stop()', function() {
      return it('stops the clock', function() {
        this.standard_env.start();
        return this.standard_env.stop().should.be.ok;
      });
    });
    describe('populationSize()', function() {
      return it('tells how many entities there are', function() {
        this.standard_env.populationSize().should.eql(0);
        return this.custom_env.populationSize().should.eql(1);
      });
    });
    describe('reset()', function() {
      return it('goes to original state from instantiation', function() {
        this.custom_env.date = 100;
        this.custom_env.tickSpeed = 500;
        this.custom_env.population = ['blahh'];
        this.custom_env.reset();
        this.custom_env.date.should.eql(0);
        this.custom_env.tickSpeed.should.eql(1500);
        return this.custom_env.population.should.eql([this.test_entity]);
      });
    });
    return describe('tick()', function() {
      return it('updates entities', function() {
        var new_age, old_age, responded_to_tick;
        old_age = this.test_entity.age;
        this.custom_env.tick();
        new_age = this.test_entity.age;
        if (old_age < new_age) {
          responded_to_tick = true;
        }
        return responded_to_tick.should.be["true"];
      });
    });
  });

}).call(this);
