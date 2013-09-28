define ["jquery", "underscore", "backbone", "jqueryform", "handlebars", "text!../templates/status.hbs"], ($, _, Backbone, jqueryform, Handlebars, statusTemplate) ->
  'use strict'
  
  class StatusCreationView extends Backbone.View

    el: ".statuses"
    
    template: Handlebars.compile(statusTemplate)

    events:
      "click #create-status"  :  "handleCreation"

    initialize: ->
      @statuses = []

    render: ->
      $(@el).html(@template())

    showMessage: (message) ->
      '<div data-alert class="alert-box">' + message + '<a href="#" class="close">&times;</a></div>'

    handleCreation: (e) ->
      @statuses.push $("#status").val()
      $("#status").val("")
      console.log @statuses