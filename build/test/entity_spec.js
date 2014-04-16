(function() {
  var simulator;

  simulator = require('../terrarium');

  describe('Entity', function() {
    beforeEach(function() {
      this.standard_env = new simulator.Environment;
      return this.test_entity = new simulator.Entity({
        environment: this.standard_env
      });
    });
    describe('constructor', function() {
      it('uses defaults', function() {
        this.test_entity.age.should === 0;
        return this.test_entity.name.should === ("Entity" + (this.test_entity.environment.populationSize()));
      });
      return it('throws exceptions for orphan entities', function() {
        return function() {
          return new simulator.Entity(should["throw"]('Entities may not exist outside of an  environment. You must specify the environment on instantiation.'));
        };
      });
    });
    describe('onTick()', function() {
      return it('increments object age onTick', function() {
        var is_older, new_age, old_age;
        old_age = this.test_entity.age;
        this.test_entity.onTick();
        new_age = this.test_entity.age;
        is_older = old_age < new_age;
        return is_older.should.be["true"];
      });
    });
    return describe('destroy()', function() {
      return it('implodes', function() {
        var got_smaller, new_pop, old_pop;
        old_pop = this.standard_env.populationSize();
        this.test_entity.destroy();
        new_pop = this.standard_env.populationSize();
        got_smaller = old_pop > new_pop;
        got_smaller.should.be["true"];
        return this.test_entity.should.not.be;
      });
    });
  });

}).call(this);
