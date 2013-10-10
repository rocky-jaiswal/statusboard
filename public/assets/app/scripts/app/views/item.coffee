define ["jquery", "underscore", "backbone", "foundation", "handlebars", "text!../templates/item.hbs"], ($, _, Backbone, foundation, Handlebars, itemTemplate) ->
  'use strict'
  
  class ItemView extends Backbone.View

    el: ".modals"

    events:
      "click  #delete-item"             : "deleteItem"

    template: Handlebars.compile(itemTemplate)

    initialize: () ->
      @showItem(@options.itemId)

    showItem: (id) ->
      $.ajax("/items/" + id, {type: "GET", success: @showItemModal, error: @handleError})

    showItemModal: (data) =>
      $(".modals").empty()
      data.keyVals = null if _.isEmpty data.keyVals
      $(".modals").append @template({item: data})
      $("#show-item-modal").foundation('reveal', 'open')

    handleError: (data) ->
      console.log data
