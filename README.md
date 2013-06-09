# Terrarium
## A simple simulation engine

(c) 2013, Rick Carlino. See enclosed MIT license. Pull requests welcome ;-)

#### About
This is a side project I am writing as a simulation engine for turn based games. It slightly resembles a discrete event simulation (DES) engine, but much more simple.

#### Concepts
The codebase provides two classes, which are intended to be used for derived classes. My goal is to make this project DOM and Application agnostic, with a bias

#### Environments
The first class is 'Environment', which represents a container for all events and also controls the execution of callbacks to pieces of the simulation. This would typically encompass concepts such as a 'world' or single instance of a game in progress.

#### Entities
The next class is 'Entity', which can be any one thing that interacts with the Environment, or other Entities. This might represent things such as players, or other factors involved with the game.

Once the Environment is start()ed, it will continuously cycle through each Entity in the population of entities at a uniform pace, allowing each entity to perform callbacks within its respective onTick() method.

#### Technical stuff
Written with Coffeescript, Mocha / ShouldJS (for testing) and docco for documentation.

## Example 1 - Rock Paper Scissors
/examples/rock_paper_scissors.coffee is a very simple example of comparing between two strategies. In this case, we have two strategies: the first is to throw a random hand every round and the second is to only throw rock. Obviously, this will return a 'tie' if allowed to run infinitely, but it shows a good example of how to extend the Entity and Environment classes.


#### Results after 1000 rounds (1st iteration):
Player1 (Rock Only): 326

Player2 (Random): 342

#### Results after 1000 rounds (2nd iteration):
Player1 (Rock Only): 301

Player2 (Random): 373

#### Results after 1000 rounds (3rd iteration):
Player1 (Rock Only): 340

Player2 (Random): 339

#### Results after 1000 rounds (4th iteration):
Player1 (Rock Only): 339

Player2 (Random): 318

## Goodness of fit for Example 1 (Thanks, Jason Goldberger)