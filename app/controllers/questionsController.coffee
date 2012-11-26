Spine = require('spine')
Quiz  = require('models/quiz')

class QuestionsController extends Spine.Controller
  className: "questionController"
  events : 
    'click .answer' : 'selectAnswer'
    'click button' : 'start'

  constructor: ->
    super 

    @quiz = new Quiz 
      questions: require('lib/questions')
    @renderIntro()

    Quiz.bind("quizDone", @renderResult)

  render:=>
    @html require('views/question')
      question: @quiz.currentQuestion

  start:=>
    @quiz.nextQuestion()
    @render()

  renderIntro:=>
    @html require('views/intro')

  renderResult:=>
    console.log "quiz is #{@quiz.result()}"
    console.log require('lib/projects')
    @html require('views/result')
      project: @quiz.result()

  selectAnswer:(e)=>
    @quiz.recordAnswer($(e.currentTarget).data().id)
    if @quiz.nextQuestion()
      @render()


module.exports = QuestionsController