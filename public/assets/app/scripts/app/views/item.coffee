define ["jquery", "underscore", "backbone", "foundation", "handlebars", "text!../templates/item.hbs"], ($, _, Backbone, foundation, Handlebars, itemTemplate) ->
  'use strict'
  
  class ItemView extends Backbone.View

    el: ".modals"

    events:
      "click  #delete-item" : "deleteItem"

    template: Handlebars.compile(itemTemplate)

    initialize: () ->
      @$el.empty()
      @showItem(@options.itemId)

    showItem: (id) ->
      $.ajax("/items/" + id, {type: "GET", success: @showItemModal, error: @handleError})

    showItemModal: (data) =>
      data.keyVals = null if _.isEmpty data.keyVals
      $(".modals").html @template({item: data})
      $("#show-item-modal").foundation('reveal', 'open')

    deleteItem: (e) ->
      id = $(e.currentTarget).data("id")
      $("#show-item-modal").foundation('reveal', 'close')
      $.ajax("/items/" + id, {type: "DELETE", data: {boardId: @options.boardId}, success: @handleSuccess, error: @handleError})

    handleSuccess: (data) =>
      @$el.empty()
      @undelegateEvents()
      @options.boardModel.set(data)

    handleError: (data) ->
      alert(JSON.parse(data.responseText).message)
      location.reload()