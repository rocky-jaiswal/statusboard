"use strict"
require.config
  shim:
    underscore:
      exports: "_"

    backbone:
      deps: ["underscore", "jquery"]
      exports: "Backbone"

    foundation:
      deps: ["jquery"]
      exports: "foundation"

    jqueryform:
      deps: ["jquery"]
      exports: "jqueryform"

    jqueryui:
      deps: ["jquery"]
      exports: "jqueryui"

    handlebars:
      exports: "Handlebars"

  paths:
    jquery: "../bower_components/jquery/jquery"
    backbone: "../bower_components/backbone/backbone"
    underscore: "../bower_components/underscore/underscore"
    foundation: "../bower_components/vendor/foundation"
    jqueryui: "../bower_components/jquery-ui/jquery-ui"
    jqueryform: "../bower_components/jquery-form/jquery.form"
    handlebars: "../bower_components/handlebars/handlebars"
    text: "../bower_components/requirejs-text/text"

require ["backbone", "jquery", "foundation", "app/init"], (Backbone, $, foundation, Init) ->
  $ ->
    $(document).foundation()
    Init.init()