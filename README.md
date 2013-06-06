Terrarium
==========

A simple simulation engine
--------------------------

(c) 2013, Rick Carlino. See enclosed MIT license. Pull requests welcome ;-)

About
-----
This is a side project I am writing as a simulation engine for turn based games. It slightly resembles a discrete event simulation (DES) engine, but much more simple.

Concepts
--------
The codebase provides two classes, which are intended to be used for derived classes.

Environments
------------
The first class is 'Environment', which represents a container for all events and also controls the execution of callbacks to pieces of the simulation. This would typically encompass concepts such as a 'world' or single instance of a game in progress.

Entities
--------
The next class is 'Entity', which can be any one thing that interacts with the Environment, or other Entities. This might represent things such as players, or other factors involved with the game.

Once the Environment is start()ed, it will continuously cycle through each Entity in the population of entities at a uniform pace, allowing each entity to perform callbacks within its respective onTick() method.

Technical stuff
---------------
Written with Coffeescript, Mocha / ShouldJS (for testing) and docco for documentation.