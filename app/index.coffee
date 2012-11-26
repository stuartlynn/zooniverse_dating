require('lib/setup')

Spine = require('spine')
questionsController = require('controllers/questionsController')
class App extends Spine.Controller
  constructor: ->
    super
    @append new questionsController()


module.exports = App
    