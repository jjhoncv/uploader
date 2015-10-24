yOSON.AppCore.addModule "reader", (Sb) ->  
  
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
      
      return

  initialize = (opts) ->
    st = $.extends(defaults, opts, {})
    catchDom(st)
    suscribeEvents()
    return

  return {
    init: initialize
  }