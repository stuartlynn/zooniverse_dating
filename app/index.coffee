require('lib/setup')

Spine = require('spine')
questionsController = require('controllers/questionsController')
class App extends Spine.Controller
  constructor: ->
    super
    @append "<img class='heart' src='heart.jpg'></img>"
    @append new questionsController()


module.exports = App
    