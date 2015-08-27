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
              yOSON.AppCore.runModule('preview_images', {
                form: "form",
                preview: ".preview-files",
                input: "input[type=file]"
              });
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
