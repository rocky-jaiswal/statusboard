define ["jquery", "underscore", "backbone", "jqueryform", "jqueryui", "foundation", "handlebars", "text!../templates/lanes.hbs", "../models/board"], ($, _, Backbone, jqueryform, jqueryui, foundation, Handlebars, lanesTemplate, BoardModel) ->
  'use strict'
  
  class BoardView extends Backbone.View

    events:
      "click  #add-item"       : "addItem"
      "click  #add-key-value"  : "addKeyValue"
      "submit #create-item"    : "handleSubmit"

    template: Handlebars.compile(lanesTemplate)

    initialize: ->
      @keyVals = []
      @loadModel()
      @render()

    loadModel: ->
      @boardId = $("#board-show-view").data("board-id")
      @boardModel = new BoardModel({id: @boardId})
      @boardModel.fetch({async: false})

    render: ->
      $(".loading").hide()
      $(@el).html(@template({board: @boardModel.toJSON()}))
      @prepareDraggable()

    prepareDraggable: ->
      $(".item").draggable()
      $(".status-lane").droppable({drop: @handleDrop})

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
      title = $("#item_title").val()
      $("#add-item-modal").foundation('reveal', 'close')
      $(".loading").show()
      $.ajax("/items", {type: "POST", data: {boardId: @boardId, title: title, status: @status, keyVals: @keyVals}, success: @handleSuccess, error: @handleError})

    handleSuccess: (data) =>
      @boardModel.set(data)
      @render()

    handleError: (data) ->
      console.log data

    handleDrop: (event, ui) =>
      item_id     = $(ui.draggable["0"]).data("id")
      c_status_id = $(ui.draggable["0"]).parent().parent().data("id")
      n_status_id = $(event.target).data("id")
      
      if n_status_id isnt c_status_id
        $.ajax("/items/" + item_id + "/move", {type: "POST", data: {boardId: @boardId, newStatus: n_status_id, currentStatus: c_status_id}, success: @handleSuccess, error: @handleError})
        $(".loading").show()
      else
        @render()