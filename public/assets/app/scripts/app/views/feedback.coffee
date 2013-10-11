define ["jquery", "underscore", "backbone", "jqueryform", "handlebars", "text!../templates/feedback.hbs"], ($, _, Backbone, jqueryform, Handlebars, feedbackTemplate) ->
  'use strict'
  
  class FeedbackView extends Backbone.View

    events:
      "click #send-feedback"           :  "showForm"
      "click .close-reveal-modal"      :  "clearModal"
      "submit #create-feedback"        :  "handleSubmit"

    template: Handlebars.compile(feedbackTemplate)

    showForm: ->
      $(@el).append(@template())
      $("#feedback-modal").foundation('reveal', 'open')

    handleSubmit: (e) ->
      e.preventDefault()
      $(".button").hide()
      $form = $(e.currentTarget)
      $form.ajaxSubmit(success: @handleSuccess, error: @handleError)

    handleSuccess: (data) =>
      $(".message").html(data.message)
      
    handleError: (data) =>
      $(".message").html(JSON.parse(data.responseText).message)

    clearModal: ->
      $("#feedback-modal").foundation('reveal', 'close')
      $("#feedback-modal").remove()
