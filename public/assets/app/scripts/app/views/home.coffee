define ["jquery", "underscore", "backbone"], ($, _, Backbone) ->
  'use strict'
  
  class HomeView extends Backbone.View

    events:
      "click #show-something": "showSomething"

    initialize: ->
      console.log 1