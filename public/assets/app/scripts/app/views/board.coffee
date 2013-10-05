define ["jquery", "underscore", "backbone", "jqueryform", "foundation"], ($, _, Backbone, jqueryform, foundation) ->
  'use strict'
  
  class BoardView extends Backbone.View

    events:
      "click  #add-item"       : "addItem"
      "click  #add-key-value"  : "addKeyValue"
      "submit #create-item"    : "handleSubmit"

    initialize: ->
      @keyVals = []

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
      $("#add-item-modal").foundation('reveal', 'close')
      boardId = $("#board_id").val()
      title = $("#item_title").val()
      $.ajax("/items", {type: "POST", data: {boardId: boardId, title: title, status: @status, keyVals: @keyVals}, success: @handleSuccess, error: @handleError})

    handleSuccess: (data) =>
      $("#board-show-view").html(data)

    handleError: (data) ->
      console.log data