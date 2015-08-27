
/*
extiende del underscore _
@class underscore
@main flux/all
@author Juan Pablo
 */
yOSON.AppCore.addModule("underscore", function(Sb) {
  var fn, initialize;
  _.templateSettings = {
    evaluate: /\{\{([\s\S]+?)\}\}/g,
    interpolate: /\{\{=([\s\S]+?)\}\}/g
  };
  fn = {
    init: function() {
      log("");
    },
    template: function(id, data, fn, calbackParams) {
      var html;
      data = typeof data === 'undefined' ? {} : data;
      html = _.template($(id).html(), data);
      if (typeof calbackParams !== "undefined") {
        fn(html, calbackParams);
      } else {
        fn(html);
      }
    }
  };
  initialize = function(oP) {
    $.extend(oP);
    Sb.events(['underscore:template'], fn.template, this);
  };
  return {
    init: initialize
  };
}, ["../bower_components/underscore/underscore.js"]);


/*
Module description
@class modules
@main /home/jhonnatan/htdocs/skeletor/app/precom/coffee
@author
 */

yOSON.AppCore.addModule("preview_images", function(Sb) {
  var catchDom, defaults, dom, events, fn, initialize, st, suscribeEvents;
  defaults = {
    form: "",
    preview: "",
    input: ""
  };
  st = {};
  dom = {};
  catchDom = function(st) {
    dom.form = $(st.form);
    dom.input = $(st.input, dom.form);
  };
  suscribeEvents = function() {
    dom.input.on("change", events.selectedFiles);
  };
  events = {
    selectedFiles: function(e) {
      var files, reader;
      files = e.target.files;
      reader = new FileReader();
      reader.onload = function(e) {
        var result;
        result = {
          data: {
            images: []
          }
        };
        Sb.trigger("underscore:template", st.tpl, result, function(html) {});
      };
    }
  };
  fn = {
    functionName: function() {
      console.log("example");
    }
  };
  initialize = function(opts) {
    st = $.extend({}, defaults, opts);
    catchDom(st);
    suscribeEvents();
  };
  return {
    init: initialize
  };
}, ["../bower_components/underscore/underscore.js"]);
