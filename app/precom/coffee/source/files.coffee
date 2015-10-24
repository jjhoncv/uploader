yOSON.AppCore.addModule "files", (Sb) ->

  defaults = {
    url   : 'http://'
    files : []
    async : true
    index : 0
  }

  st = {}
  dom = {}

  

  fn =
    add: (files) ->
      fn.set(files)
      fn.make()
      return

    set: (files) ->
      st.files = files
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
      if typeof callback == 'function'
        Sb.trigger('reader:add', file, callback)
      else
        Sb.trigger('reader:add', file)
      return

    list: (callback) ->
      $.each(st.files, callback)
      return

    preview: (i, file) ->
      Sb.trigger('render:add', file)
      return

  initialize = (opts) ->
    st = $.extends(defaults, opts, {})
    Sb.events(['files:add'], fn.add, this)
    return

  return {
    init: initialize
  }