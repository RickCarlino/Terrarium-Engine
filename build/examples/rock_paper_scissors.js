(function() {
  var Game, Player, avalancheStrategy, game, randomStrategy, simulator,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  simulator = require('../terrarium');

  Player = (function(_super) {
    __extends(Player, _super);

    function Player() {
      return Player.__super__.constructor.apply(this, arguments);
    }

    Player.prototype.throwRandom = function() {
      return Math.floor(Math.random() * 3);
    };

    Player.prototype.throwRock = function() {
      return 0;
    };

    return Player;

  })(simulator.Entity);

  Game = (function(_super) {
    __extends(Game, _super);

    function Game() {
      return Game.__super__.constructor.apply(this, arguments);
    }

    Game.prototype.start = function() {
      if (this.populationSize() !== 2) {
        return console.log('Incorrect number of players. RPS is a 2 player game. Aborting.');
      }
      return Game.__super__.start.apply(this, arguments);
    };

    Game.prototype.afterTick = function(results) {
      if (this.date > 999) {
        this.stop();
        return console.log("Results after " + this.date + " rounds:\nPlayer1 (" + this.population[0].name + "): " + this.population[0].score + "\nPlayer2 (" + this.population[1].name + "): " + this.population[1].score);
      }
      return this.determineWinner(this.results[0], this.results[1]);
    };

    Game.prototype.determineWinner = function(a, b) {
      if (a.hand === b.hand) {
        return console.log("Tie!!!");
      } else if (a.hand === 0 && b.hand === 1) {
        console.log("B wins");
        return ++b.player.score;
      } else if (a.hand === 0 && b.hand === 2) {
        console.log("A wins");
        return ++a.player.score;
      } else if (a.hand === 1 && b.hand === 0) {
        console.log("A wins");
        return ++a.player.score;
      } else if (a.hand === 1 && b.hand === 2) {
        console.log("B wins");
        return ++b.player.score;
      } else if (a.hand === 2 && b.hand === 0) {
        console.log("B wins");
        return ++b.player.score;
      } else if (a.hand === 2 && b.hand === 1) {
        console.log("A wins");
        return ++a.player.score;
      }
    };

    Game.prototype.gameMap = {
      '0': 'rock',
      '1': 'paper',
      '2': 'scissors'
    };

    return Game;

  })(simulator.Environment);

  game = new Game({
    tickSpeed: 1
  });

  avalancheStrategy = new Player({
    environment: game,
    name: "Rock Only"
  });

  avalancheStrategy.onTick = function() {
    return {
      hand: this.throwRock(),
      player: this
    };
  };

  avalancheStrategy.score = 0;

  randomStrategy = new Player({
    environment: game,
    name: "Random"
  });

  randomStrategy.onTick = function() {
    return {
      hand: this.throwRandom(),
      player: this
    };
  };

  randomStrategy.score = 0;

  game.start();

}).call(this);
