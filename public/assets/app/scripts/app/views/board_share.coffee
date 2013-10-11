define ["jquery", "underscore", "backbone", "jqueryform", "jqueryui", "foundation", "handlebars", "text!../templates/lanes_view.hbs"], ($, _, Backbone, jqueryform, jqueryui, foundation, Handlebars, lanesViewTemplate) ->
  'use strict'
  
  class BoardShareView extends Backbone.View

    template: Handlebars.compile(lanesViewTemplate)

    initialize: ->
      $(".loading").show()
      @loadModel()

    loadModel: ->
      boardId = $("#board-share-view").data("board-id")
      $.ajax("/boards/" + boardId + "/share", {type: "GET", success: @render, error: @handleError})

    render: (data) =>
      $(".loading").hide()
      $(@el).html(@template({board: data}))

    handleError: (data) =>
      $(".loading").hide()
      $(".messages").append(@showMessage("Error loading board! Please try again later."))

    showMessage: (message) ->
      '<div data-alert class="alert-box">' + message + '<a href="#" class="close">&times;</a></div>'


