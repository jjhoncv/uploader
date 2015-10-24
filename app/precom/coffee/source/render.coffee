yOSON.AppCore.addModule "reader", (Sb) ->  
  
  defaults = {
    content   : '.section'
    inputFile : '.my_file'
    files: []
  }

  st = {}
  dom = {}

  catchDom = (st) ->
    dom.content   = $(st.content)
    dom.inputFile = $(st.inputFile)
    return

  suscribeEvents = ->
    dom.inputFile.on 'change', events.onChange
    return

  events = 
    onChange: (e) ->
      st.files = fn.getFilesCurrent(e)
      if fn.isFilesToUpload()
        fn.initUpload()
      return

  fn =
    add: (file, callback)->
      if fn.isSupportFileReader()
        fn.readFile(file, callback)
      return

    readFile: (file, callback)->
      reader = new FileReader()
      
      reader.onload = ((theFile) ->
        (e) ->
          file["src"] = e.target.result
          return
      )(file)
      return

    isSupportFileReader: ()->
      status = false
      if window.FileReader
        status = true
      status

  initialize = (opts) ->
    st = $.extends(defaults, opts, {})
    catchDom(st)
    suscribeEvents()
    return

  return {
    init: initialize
  }