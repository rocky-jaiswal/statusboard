define ["jquery", "backbone", "require", "app/views/login", "app/views/home", "app/views/boardcreation", "app/views/board"], ($, Backbone, require, LoginView, HomeView, BoardCreationView, BoardView) ->
  
  'use strict'

  class Init
    
    @init: ->
      #HomeView  = require("app/views/home")
      
      mapping =
        "#login-view"           : LoginView
        "#board-index-view"     : HomeView
        "#board-new-view"       : BoardCreationView
        "#board-show-view"      : BoardView

      initialized = {}

      for selector, view of mapping
        if $("body").has(selector).length isnt 0
          view = new view({el: selector}) unless initialized[selector]
          initialized[selector] = true