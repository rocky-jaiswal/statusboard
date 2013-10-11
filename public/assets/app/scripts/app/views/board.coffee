define ["jquery", "underscore", "backbone", "jqueryform", "jqueryui", "foundation", "handlebars", "app/models/board", "app/views/item", "app/views/add_item", "text!../templates/lanes.hbs"], ($, _, Backbone, jqueryform, jqueryui, foundation, Handlebars, BoardModel, ItemView, AddItemView, lanesTemplate) ->
  'use strict'
  
  class BoardView extends Backbone.View

    events:
      "click  #add-item"                : "addItem"
      "click  #show-item"               : "showItem"

    template: Handlebars.compile(lanesTemplate)

    initialize: ->
      $(".loading").show()
      @loadModel()

    loadModel: ->
      @boardId = $("#board-show-view").data("board-id")
      @boardModel = new BoardModel({id: @boardId})
      @boardModel.on("change", @render, @)
      @boardModel.fetch({async: false})

    render: ->
      $(".loading").hide()
      $(@el).html(@template({board: @boardModel.toJSON()}))
      @prepareDraggable()

    prepareDraggable: ->
      $(".item").draggable()
      $(".status-lane").droppable({drop: @handleDrop})

    addItem: (e) ->
      status = $(e.currentTarget).data("status")
      new AddItemView({status: status, boardId: @boardId, boardModel: @boardModel})

    showItem: (e) ->
      id = $(e.currentTarget).data("id")
      new ItemView({boardId: @boardId, itemId: id, boardModel: @boardModel})

    handleDrop: (event, ui) =>
      item_id     = $(ui.draggable["0"]).data("id")
      c_status_id = $(ui.draggable["0"]).parent().parent().data("id")
      n_status_id = $(event.target).data("id")
      
      if n_status_id isnt c_status_id
        $(".loading").show()
        $.ajax("/items/" + item_id + "/move", {type: "POST", data: {boardId: @boardId, newStatus: n_status_id, currentStatus: c_status_id}, success: @handleSuccess, error: @handleError})
      else
        @render()

    handleSuccess: (data) =>
      @boardModel.set(data)
      @render()

    handleError: (data) =>
      $(".messages").append(@showMessage(JSON.parse(data.responseText).message))
      $(".loading").hide()

    showMessage: (message) ->
      '<div data-alert class="alert-box">' + message + '<a href="#" class="close">&times;</a></div>'


