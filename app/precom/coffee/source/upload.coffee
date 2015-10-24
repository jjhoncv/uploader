yOSON.AppCore.addModule "upload", (Sb) ->  
  
  defaults = {
    url   : 'http://'
    files : []
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

  fn =
    add: (file, callback)->
      data = fn.getFileToUpload(file)
      fn.ajax(data, file, callback)      
      return

    getFileToUpload: (file)->
      formData = new formData()
      formData.append("file", file)
      return formData

    ajax: (data, file, callback)->
      ajax = new XMLHttpRequest()
      ajax.open("POST", st.url)
      ajax.onload = ->
        fn.successAjax(ajax, file, callback)        
        return
      ajax.send(data)
      return

    successAjax : (ajax, file, callback)->
      if typeof callback == 'function'
          callback()
      if ajax.status is 200 and ajax.responseText.status is true

      return

  initialize = (opts) ->
    st = $.extends(defaults, opts, {})
    catchDom(st)
    suscribeEvents()
    return

  return {
    init: initialize
  }