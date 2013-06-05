#Cakefile

{exec} = require "child_process"

REPORTER = "min"

task "test", "run tests", ->
  exec "NODE_ENV=test
    mocha
    --compilers coffee:coffee-script
    --reporter #{REPORTER}
    --require coffee-script
    --require test/test_helper.coffee
    --colors
    ", (err, output) ->
      throw err if err
      console.log output