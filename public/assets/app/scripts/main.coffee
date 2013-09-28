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
      exports: "jquery"

    handlebars:
      exports: "Handlebars"

  paths:
    jquery: "../bower_components/jquery/jquery"
    backbone: "../bower_components/backbone/backbone"
    underscore: "../bower_components/underscore/underscore"
    foundation: "../bower_components/vendor/foundation"
    handlebars: "../bower_components/handlebars/handlebars"
    text: "../bower_components/requirejs-text/text"

require ["backbone", "jquery", "foundation", "app/init"], (Backbone, $, Foundation, Init) ->
  $ ->
    $(document).foundation()
    Init.init()