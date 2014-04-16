(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.Environment = (function() {
    function Environment(options) {
      var _ref, _ref1;
      if (options == null) {
        options = {};
      }
      this.start = __bind(this.start, this);
      this.tick = __bind(this.tick, this);
      this.population = (_ref = options.population) != null ? _ref : [];
      this.tickSpeed = (_ref1 = options.tickSpeed) != null ? _ref1 : 2000;
      this.date = 0;
      this.originalOptions = {
        population: this.population,
        tickSpeed: this.tickSpeed
      };
      this;
    }

    Environment.prototype.beforeTick = function(results) {
      return null;
    };

    Environment.prototype.afterTick = function(results) {
      return null;
    };

    Environment.prototype.tick = function() {
      var e, entity, result, _i, _len, _ref;
      if (this.results) {
        this.beforeTick(this.results);
      }
      this.results = [];
      _ref = this.population;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        entity = _ref[_i];
        try {
          result = entity.onTick();
          this.results.push(result);
        } catch (_error) {
          e = _error;
          null;
        }
      }
      ++this.date;
      if (this.results) {
        return this.afterTick(this.results);
      }
    };

    Environment.prototype.start = function() {
      if (this.timerId) {
        delete this.timerId;
      }
      this.timerId = setInterval((function(_this) {
        return function() {
          return _this.tick();
        };
      })(this), this.tickSpeed);
      if (this.timerId >= 0) {
        return true;
      }
      return false;
    };

    Environment.prototype.stop = function() {
      clearInterval(this.timerId);
      return true;
    };

    Environment.prototype.reset = function() {
      this.stop();
      this.population = this.originalOptions.population;
      this.tickSpeed = this.originalOptions.tickSpeed;
      this.date = 0;
      return true;
    };

    Environment.prototype.populationSize = function() {
      return this.population.length;
    };

    return Environment;

  })();

  this.Entity = (function() {
    function Entity(options) {
      var e, _ref, _ref1;
      if (options == null) {
        options = {};
      }
      this.onTick = __bind(this.onTick, this);
      try {
        this.environment = options.environment;
      } catch (_error) {
        e = _error;
        console.error('Entities may not exist outside of an  environment. You must specify the environment on instantiation.');
        delete this;
      }
      try {
        this.environment.population.push(this);
      } catch (_error) {
        e = _error;
        console.error('Was unable to push entity into environment.');
        delete this;
      }
      this.age = (_ref = options.age) != null ? _ref : 0;
      this.name = (_ref1 = options.name) != null ? _ref1 : "Entity" + (this.environment.populationSize() + 1);
      this.options = {
        age: this.age,
        name: this.name,
        environment: this.environment
      };
    }

    Entity.prototype.onTick = function() {
      return ++this.age;
    };

    Entity.prototype.destroy = function() {
      var destroyThisIndex;
      destroyThisIndex = this.environment.population.indexOf(this);
      this.environment.population.pop(destroyThisIndex);
      return delete this;
    };

    return Entity;

  })();

}).call(this);
