yOSON.AppCore.addModule "main", (Sb) ->  
  
  defaults = {
    content   : '.section'
    inputFile : '.my_file'
    files: []
  }

  st = {}
  dom = {}

  catchDom = (st) ->
    dom.content = $(st.content)
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
    initUpload: ->
      Sb.trigger('validate:validFiles')
      Sb.trigger('validate:getFiles', fn.filesToUpload)
      return

    filesToUpload: (files) ->
      Sb.trigger('files:add', files)
      return

    sharedFiles: (callback) ->
      callback.call(st.files, this)
      return

    getFilesCurrent: (e) ->
      files  = []
      target = e.target

      if target.files
        files = target.files
      else
        files.push target.value
      files

    isFilesToUpload: ->
      total = st.files.length
      if total > 0 then true else false

  initialize = (opts) ->
    st = $.extends(defaults, opts, {})
    catchDom(st)
    suscribeEvents()
    return

  return {
    init: initialize
  }