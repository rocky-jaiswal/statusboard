define ["jquery", "underscore", "backbone", "jqueryform", "foundation", "handlebars", "text!../templates/lanes.hbs", "../models/board"], ($, _, Backbone, jqueryform, foundation, Handlebars, lanesTemplate, BoardModel) ->
  'use strict'
  
  class BoardView extends Backbone.View

    events:
      "click  #add-item"       : "addItem"
      "click  #add-key-value"  : "addKeyValue"
      "submit #create-item"    : "handleSubmit"

    template: Handlebars.compile(lanesTemplate)

    initialize: ->
      @keyVals = []
      boardId = $("#board-show-view").data("board-id")
      @boardModel = new BoardModel({id: boardId})
      @boardModel.fetch({async: false})
      @render()

    render: ->
      $(@el).html(@template({board: @boardModel.toJSON()}))

    getTempl: (key, val) ->
      '<span class="label">' +  key + ' <i class="icon-arrow-right"></i> ' + val + '</span>'

    addItem: (e) ->
      @status = $(e.currentTarget).data("status")
      $("#add-item-modal").foundation('reveal', 'open')

    addKeyValue: (e) ->
      k = $("#item-key").val()
      v = $("#item-value").val()
      if k and v
        obj = {}
        obj["iKey"] = k
        obj["iVal"] = v
        @keyVals.push obj
        $(".key-vals").append(@getTempl(k, v))
        @clearKeyValueFields()

    clearKeyValueFields: () ->
      $("#item-key").val("")
      $("#item-value").val("")
      $("#item-key").focus()

    handleSubmit: (e) ->
      e.preventDefault()
      boardId = $("#board_id").val()
      title   = $("#item_title").val()
      $("#add-item-modal").foundation('reveal', 'close')
      $.ajax("/items", {type: "POST", data: {boardId: boardId, title: title, status: @status, keyVals: @keyVals}, success: @handleSuccess, error: @handleError})

    handleSuccess: (data) =>
      @boardModel.set(data)
      @render()

    handleError: (data) ->
      console.log data