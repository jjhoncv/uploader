schema = 'modules':
  'allModules': ->
    #alert("sector donde corre sin importar el nombre del modulo");
    return
  'default':
    'allControllers': ->
      #alert("sector donde corre sin importar el nombre del controller en el modulo usuario");
      return
    'controllers':
      'index':
        'allActions': ->
        'actions':
          'index': ->
            yOSON.AppCore.runModule 'underscore'
            yOSON.AppCore.runModule 'files'
            yOSON.AppCore.runModule 'file_reader'
            yOSON.AppCore.runModule 'preview_images',
                      form    : "form"
                      preview : "#preview_files" ,
                      item    : ".item"
                      tpl     : "#previewFiles"
                      input   : "input[type=file]"
                      btnCancel : ".cancel"
            yOSON.AppCore.runModule 'submit_images'          
            return
          'byDefault': ->
            #alert("si no existe un action, este action corre por defecto");
            return
      'byDefault': ->
        #alert("si no existe un controller debería ser por default este controller");
        return
  'byDefault': ->
    #alert('corriendo modulo por defecto');
    return