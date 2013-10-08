define ["jquery", "underscore", "backbone"], ($, _, Backbone) ->
  'use strict'
  
  class BoardModel extends Backbone.Model

    urlRoot: "/boards"