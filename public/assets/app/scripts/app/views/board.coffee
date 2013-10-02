define ["jquery", "underscore", "backbone", "jqueryform", "foundation"], ($, _, Backbone, jqueryform, foundation) ->
  'use strict'
  
  class BoardView extends Backbone.View

    events:
      "click #add-item"       : "addItem"
      "click #add-key-value"  : "addKeyValue"

    initialize: ->
      @kayVals = []

    getTempl: ->
      '<input type="text" class="item-key" placeholder="Key"/><input type="text" class="item-value" placeholder="Value"/>'

    addItem: (e) ->
      $("#add-item-modal").foundation('reveal', 'open')

    addKeyValue: (e) ->
      $(".key-vals").append(@getTempl())