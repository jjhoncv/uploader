yOSON.AppCore.addModule "files", (Sb) ->

  defaults = {
    files : []
    async : true
    index : 0
    tpl   : "#file"
  }

  st = {}
  dom = {}
  
  catchDom = ->
    dom.tpl = $(st.tpl)
    return

  fn =
    add: (files) ->
      fn.set(files)
      fn.make()
      return

    set: (files) ->
      st.files = files
      fn.list(fn.addTpl)
      return

    make: ->
      type = 'sync'
      type = if st.async then 'a' + type else ''
      fn.list(fn.preview)
      fn[type]()
      return

    async: ->
      fn.list(i, file) ->
        fn.unique(file)
        return
      return

    sync: ->
      file = st.files[st.index]
      fn.unique(file, fn.next)
      return

    next: ->
      st.index++
      file = st.files[st.index]
      fn.unique(file, fn.next)
      return

    unique: (file, callback) ->
      file["html"] = dom.tpl
      if typeof callback == 'function'
        Sb.trigger('reader:add', file, callback)
      else
        Sb.trigger('reader:add', file)
      return

    list: (callback) ->
      $.each(st.files, callback)
      return

    addTpl: (i, file)->
      file["html"] = dom.tpl
      st.files[i] = file
      return 
    
    preview: (i, file) ->
      Sb.trigger('render:add', file)
      return

  initialize = (opts) ->
    st = $.extends(defaults, opts, {})
    catchDom()
    Sb.events(['files:add'], fn.add, this)
    return

  return {
    init: initialize
  }