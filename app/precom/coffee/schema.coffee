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
            yOSON.AppCore.runModule 'preview_images',
                      form    : "form"
                      preview : ".preview-files" ,
                      input   : "input[type=file]"
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