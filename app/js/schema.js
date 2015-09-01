var schema;

schema = {
  'modules': {
    'allModules': function() {},
    'default': {
      'allControllers': function() {},
      'controllers': {
        'index': {
          'allActions': function() {},
          'actions': {
            'index': function() {
              yOSON.AppCore.runModule('underscore');
              yOSON.AppCore.runModule('files');
              yOSON.AppCore.runModule('file_reader');
              yOSON.AppCore.runModule('preview_images', {
                form: "form",
                preview: "#preview_files",
                item: ".item",
                tpl: "#previewFiles",
                input: "input[type=file]",
                btnCancel: ".cancel"
              });
              yOSON.AppCore.runModule('submit_images');
            },
            'byDefault': function() {}
          }
        },
        'byDefault': function() {}
      }
    },
    'byDefault': function() {}
  }
};
