define ["jquery", "underscore", "backbone", "jqueryform", "app/views/statuscreation"], ($, _, Backbone, jqueryform, StatusCreationView) ->
  'use strict'
  
  class BoardCreationView extends Backbone.View

    events:
      "submit #create-board"  :  "handleSubmit"

    initialize: ->
      console.log 1

    showMessage: (message) ->
      '<div data-alert class="alert-box">' + message + '</div>'

    handleSubmit: (e) ->
      $form = $(e.currentTarget)
      e.preventDefault()
      $form.ajaxSubmit(success: @handleSuccess, error: @handleError)

    handleSuccess: (d) =>
      $(".messages").append(@showMessage("Board Created Successfully!"))
      $("form#create-board").slideUp("slow")
      console.log d
      scv = new StatusCreationView()
      scv.render()

    handleError: (d) ->
      console.log d