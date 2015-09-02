
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
}, ["js/libs/underscore/underscore.js"]);


/*
Module description
@class files
@main /home/jhonnatan/htdocs/uploader/app/precom/coffee
@author
 */

yOSON.AppCore.addModule("files", function(Sb) {
  var files, fn, initialize;
  files = [];
  fn = {
    add: function(file) {
      files.push(file);
    },
    get: function(callbackDeal) {
      callbackDeal.call(this, files);
    },
    del: function(key) {
      files.splice(key, 1);
    }
  };
  initialize = function() {
    Sb.events(['files:add'], fn.add, this);
    Sb.events(['files:get'], fn.get, this);
    Sb.events(['files:del'], fn.del, this);
  };
  return {
    init: initialize
  };
});


/*
Validacion de FileReader
@class underscore
@main flux/all
@author Juan Pablo
 */

yOSON.AppCore.addModule("file_reader", function(Sb) {
  var fn, initialize;
  fn = {
    setFile: function(file, image, callback) {
      var reader;
      if (window.FileReader) {
        reader = new FileReader();
        reader.onload = function(e) {
          fn.loadReader(e, file, image, callback);
        };
        reader.readAsDataURL(file);
      } else {
        image["title"] = file.name;
        image["src"] = "";
        callback(image);
      }
    },
    loadReader: function(e, file, image, callback) {
      image["src"] = e.target.result;
      image["title"] = file.name;
      callback(file, image);
    }
  };
  initialize = function(oP) {
    Sb.events(['file_reader:setFile'], fn.setFile, this);
  };
  return {
    init: initialize
  };
});


/*
Modulo que implementa la vista preliminar de las imagenes
@class modules
@main /home/jhonnatan/htdocs/skeletor/app/precom/coffee
@author
 */

yOSON.AppCore.addModule("preview_images", function(Sb) {
  var catchDom, defaults, dom, events, fn, image, initialize, st, suscribeEvents;
  defaults = {
    form: "",
    item: "",
    preview: "",
    input: "",
    tpl: "",
    btnCancel: ""
  };
  st = {};
  dom = {};
  image = {};
  catchDom = function(st) {
    dom.form = $(st.form);
    dom.input = $(st.input, dom.form);
    dom.preview = $(st.preview, dom.form);
  };
  suscribeEvents = function() {
    dom.input.on("change", events.selectedFiles);
  };
  events = {
    selectedFiles: function(e) {
      fn.prepare_data(e.target.files);
    },
    cancelFile: function(e) {
      var ele, key;
      ele = $(e.target).parents(st.item);
      key = ele.index();
      ele.remove();
      Sb.trigger("files:del", key);
    }
  };
  fn = {
    prepare_data: function(files) {
      var file, index;
      index = 0;
      while (index < files.length) {
        file = files[index];
        Sb.trigger("file_reader:setFile", file, image, fn.setFileImage);
        index++;
      }
    },
    setFileImage: function(file, image) {
      Sb.trigger("underscore:template", st.tpl, image, fn.getMergeData);
      Sb.trigger("files:add", file);
    },
    getMergeData: function(html) {
      var span;
      span = $("<span></span>", {
        text: "cancel",
        "class": "cancel",
        click: events.cancelFile
      });
      html = $(html).append(span);
      dom.preview.append(html);
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
});


/*
Modulo que realiza el submit 
@class modules
@main /home/jhonnatan/htdocs/skeletor/app/precom/coffee
@author
 */

yOSON.AppCore.addModule("submit_images", function(Sb) {
  var catchDom, defaults, dom, events, fn, initialize, st, suscribeEvents;
  defaults = {
    parent: "form",
    el: ".submit"
  };
  st = {};
  dom = {};
  catchDom = function() {
    dom.parent = $(st.parent);
    dom.el = $(st.el, dom.parent);
  };
  suscribeEvents = function() {
    dom.el.on("submit", events.submit);
  };
  events = {
    submit: function(e) {}
  };
  fn = {
    functionName: function() {
      console.log("example");
    }
  };
  initialize = function(opts) {
    st = $.extend({}, defaults, opts);
    catchDom();
    suscribeEvents();
  };
  return {
    init: initialize
  };
});
