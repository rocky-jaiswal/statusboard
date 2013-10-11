define ["jquery", "underscore", "backbone", "foundation", "handlebars", "text!../templates/add_item.hbs"], ($, _, Backbone, foundation, Handlebars, addItemTemplate) ->
  'use strict'
  
  class AddItemView extends Backbone.View

    el: ".modals"

    events:
      "click  #delete-item"             : "deleteItem"
      "click  #add-key-value"           : "addKeyValue"
      "click  .close-reveal-modal"      : "clearModal"
      "submit #create-item"             : "handleSubmit"

    template: Handlebars.compile(addItemTemplate)

    initialize: ->
      @$el.empty()
      @keyVals = []
      @render()

    render: ->
      $(".modals").html(@template())
      $("#add-item-modal").foundation('reveal', 'open')

    getTempl: (key, val) ->
      '<tr><td>' + key + '</td><td><i class="icon-arrow-right"></i></td><td>' + val + '</td></tr>'

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
      $.ajax("/items", {type: "POST", data: {boardId: @options.boardId, title: title, status: @options.status, keyVals: @keyVals}, success: @handleSuccess, error: @handleError})

    handleSuccess: (data) =>
      @$el.empty()
      @undelegateEvents()
      @options.boardModel.set(data)

    handleError: (data) ->
      @$el.empty()
      @undelegateEvents()
      alert(JSON.parse(data.responseText).message)

    clearModal: ->
      $("#add-item-modal").foundation('reveal', 'close')
      @$el.empty()
      @undelegateEvents()
