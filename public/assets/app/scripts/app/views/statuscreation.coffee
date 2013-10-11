define ["jquery", "underscore", "backbone", "jqueryform", "handlebars", "text!../templates/status.hbs"], ($, _, Backbone, jqueryform, Handlebars, statusTemplate) ->
  'use strict'
  
  class StatusCreationView extends Backbone.View

    el: ".statuses"
    
    template: Handlebars.compile(statusTemplate)

    events:
      "click #create-status"  : "addStatus"
      "click #remove-status"  : "removeStatus"
      "click #save-status"    : "saveStatus"

    initialize: (@options) ->
      @statuses = []

    render: ->
      $(@el).html(@template({boardId: @options.boardId}))

    getTempl: (term) ->
      '<span class="success label">' +  term + '<a href="#" data-term-name="'+ term + '" id="remove-status">&times;</a></span>'

    showMessage: (message) ->
      '<div data-alert class="alert-box">' + message + '</div>'

    addStatus: (e) ->
      term = $("#status").val()
      if term and term.length > 0
        @statuses.push("" + term)
        $("#status-list").append(@getTempl("" + term))
      $("#status").val("")
      $("#status").focus()

    removeStatus: (e) ->
      elem = $(e.currentTarget)
      elem.parent().hide()
      term = elem.data("term-name")
      @statuses = _.without(@statuses, "" + term)

    saveStatus: (e) ->
      if @statuses.length is 0
        alert "Please add a Status first"
      else
        $.ajax("/statuses", {type: "POST", data: {boardId: @options.boardId, statuses: @statuses}, success: @statusSuccess, error: @statusError})

    statusSuccess: (data) =>
      $(".messages").append(@showMessage(@statuses.length + " statuses created successfully!"))
      $("#create-status-form").slideUp("slow")
      $("#save-status").hide()
      $("#status-list").hide()
      $(".show-board").removeClass("hidden")

    statusError: (data) =>
      $(".messages").append(@showMessage("Error while creating statuses. Please try again later."))