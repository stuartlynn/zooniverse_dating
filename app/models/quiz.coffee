Spine = require('spine')

class Quiz extends Spine.Model
  @configure 'Quiz', 'questions', 'scores'

  numberOfQuestions: 5

  constructor:->
    super 
    for question in @questions
      question.asked = false 
    @done = false 
    @numnberOfAnswers = 0
    @projects = require('lib/projects')
    @scores ={}

  nextQuestion:=>
    if @quizDone()
      return false
    else
      return @currentQuestion = @unaskedQuestions()[Math.random()*@unaskedQuestions.length]

  quizDone:=>
    @numberOfQuestions == @numnberOfAnswers

  unaskedQuestions:=>
    (question for question in @questions when question.asked==false)

  recordAnswer:(answerId)=>
    @numnberOfAnswers+=1 
    @trigger('quizDone') if @quizDone()
    
    project = @currentQuestion.answers[answerId].score

    if project?
      @scores[project] ||= 0 
      @scores[project] +=1
    @currentQuestion.asked=true
  
  result:=>
    max = 0
    maxProject =""
    console.log "Scores are ", @scores
    for project, value of @scores 
      if value > max 
        max = value 
        maxProject=project
    maxProject
    console.log maxProject
    @projectForName maxProject

  projectForName:(name)=>
    project = (project for project in @projects when project.name == name)[0]



module.exports = Quiz