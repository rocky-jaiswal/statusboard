define ["jquery", "underscore", "backbone", "jqueryform", "app/views/statuscreation"], ($, _, Backbone, jqueryform, StatusCreationView) ->
  'use strict'
  
  class BoardCreationView extends Backbone.View

    events:
      "submit #create-board"  :  "handleSubmit"

    initialize: ->
      

    showMessage: (message) ->
      '<div data-alert class="alert-box">' + message + '</div>'

    handleSubmit: (e) ->
      $form = $(e.currentTarget)
      e.preventDefault()
      $form.ajaxSubmit(success: @handleSuccess, error: @handleError)

    handleSuccess: (data) =>
      $(".messages").append(@showMessage("Board " + data.name + " Created Successfully!"))
      $("form#create-board").slideUp("slow")
      scv = new StatusCreationView({boardId: data.id.$oid})
      scv.render()

    handleError: (data) ->
      $(".messages").append(@showMessage("Error while creating board. Name cannot be null or duplicate"))