define ["jquery", "underscore", "backbone", "jqueryform", "handlebars", "text!../templates/status.hbs"], ($, _, Backbone, jqueryform, Handlebars, statusTemplate) ->
  'use strict'
  
  class StatusCreationView extends Backbone.View

    el: ".statuses"
    
    template: Handlebars.compile(statusTemplate)

    events:
      "click #create-status"  : "addStatus"
      "click #remove-status"  : "removeStatus"
      "click #save-status"    : "saveStatus"

    initialize: ->
      @statuses = []

    render: ->
      $(@el).html(@template())

    getTempl: (term) ->
      '<span class="success label">' +  term + '<a href="#" data-term-name="'+ term + '" id="remove-status">&times;</a></span>'

    showMessage: (message) ->
      '<div data-alert class="alert-box">' + message + '<a href="#" class="close">&times;</a></div>'

    addStatus: (e) ->
      term = $("#status").val()
      @statuses.push term
      $("#status-list").append(@getTempl(term)) if term and term.length > 0
      $("#status").val("")
      $("#status").focus()

    removeStatus: (e) ->
      elem = $(e.currentTarget)
      elem.parent().hide()
      term = elem.data("term-name")
      @statuses = _.without(@statuses, term)

    saveStatus: (e) ->
      if @statuses.length is 0
        alert "Please add a Status first"
        return
      else
        console.log @statuses