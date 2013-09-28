define ["jquery", "underscore", "backbone"], ($, _, Backbone) ->
  'use strict'
  
  class LoginView extends Backbone.View

    events:
      "click #show-sign-in": "showSignIn"
      "click #show-sign-up": "showSignUp"

    initialize: ->
      $(".sign-up").hide()
      $("#show-sign-in").hide()

    showSignIn: ->
      $("#show-sign-in").hide()
      $(".sign-up").hide()
      $(".sign-in").show()
      $("#show-sign-up").show()

    showSignUp: ->
      $("#show-sign-up").hide()
      $(".sign-in").hide()
      $(".sign-up").show()
      $("#show-sign-in").show()

