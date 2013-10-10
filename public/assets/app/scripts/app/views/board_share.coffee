define ["jquery", "underscore", "backbone", "jqueryform", "jqueryui", "foundation", "handlebars", "text!../templates/lanes_view.hbs"], ($, _, Backbone, jqueryform, jqueryui, foundation, Handlebars, lanesViewTemplate) ->
  'use strict'
  
  class BoardShareView extends Backbone.View

    template: Handlebars.compile(lanesViewTemplate)

    initialize: ->
      @loadModel()

    loadModel: ->
      boardId = $("#board-share-view").data("board-id")
      $(".loading").show()
      $.ajax("/boards/" + boardId + "/share", {type: "GET", success: @render, error: @handleError})

    render: (data) =>
      $(".loading").hide()
      $(@el).html(@template({board: data}))

    handleError: (data) =>
      console.log data
