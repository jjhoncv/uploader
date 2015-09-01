###
extiende del underscore _
@class underscore
@main flux/all
@author Juan Pablo
###
yOSON.AppCore.addModule "underscore", (Sb) ->
	_.templateSettings =
		evaluate: /\{\{([\s\S]+?)\}\}/g
		interpolate: /\{\{=([\s\S]+?)\}\}/g

	fn =
		init : ->
			log ""
			return
		template: (id, data, fn, calbackParams) ->
			data = if typeof data == 'undefined' then {} else data
			html = _.template($(id).html(), data)

			if typeof calbackParams != "undefined"
				fn(html, calbackParams)
			else 
				fn(html)
			return

	initialize = (oP) ->
		$.extend oP
		Sb.events(['underscore:template'], fn.template, this)
		return

	return {
		init: initialize
	}
, ["js/libs/underscore/underscore.js"]



###
Module description
@class files
@main /home/jhonnatan/htdocs/uploader/app/precom/coffee
@author 
###

yOSON.AppCore.addModule "files", (Sb) ->
	
	files = []

	fn = {
		add : (file)->
			files.push(file)
			return

		getAll : (callbackDeal)->
			callbackDeal.call(this, files)
			return

		del : (key)->
			total = files.length
			files.splice(key, total)
			###i = 0
			while i < total
				file = files[i]
				if file.key == key
					slice(i, total)
					return
				i++###
			console.log("key", key)
			console.log("total", total)
			console.log("files", files)

			return
	}
	initialize = ->
		Sb.events(['files:add'], fn.add, this)
		Sb.events(['files:getAll'], fn.getAll, this)
		Sb.events(['files:del'], fn.del, this)
		return

	return {
		init: initialize
	}


###
Validacion de FileReader
@class underscore
@main flux/all
@author Juan Pablo
###
yOSON.AppCore.addModule "file_reader", (Sb) ->
	
	fn =
		setFile : (file, image, callback)->

			if (window.FileReader)
				reader = new FileReader()
				reader.onload = (e)->
					fn.loadReader(e, file, image, callback)
					return
				reader.readAsDataURL(file)
			else
				image["title"] = file.name
				image["src"] = ""
				callback(image)
			return

		loadReader : (e, file, image, callback) ->
			image["src"] = e.target.result
			image["title"] = file.name
			callback(file, image)
			return
		
	initialize = (oP) ->		
		Sb.events(['file_reader:setFile'], fn.setFile, this)
		return

	return {
		init: initialize
	}



###
Modulo que implementa la vista preliminar de las imagenes
@class modules
@main /home/jhonnatan/htdocs/skeletor/app/precom/coffee
@author 
###

yOSON.AppCore.addModule "preview_images", (Sb) ->
	defaults = {
		form 		: ""
		item 		: ""
		preview 	: ""
		input		: ""
		tpl 		: ""
		btnCancel 	: ""
	}
	
	st = {}
	dom = {}

	image = {}

	catchDom = (st) ->
		dom.form 	= $(st.form)
		dom.input 	= $(st.input, dom.form)
		dom.preview = $(st.preview, dom.form)
		return	

	suscribeEvents = () ->
		dom.input.on "change", events.selectedFiles
		dom.btnCancel.on "click", events.cancelFile
		return

	events = {
		selectedFiles : (e)->
			fn.prepare_data(e.target.files)
			return

		cancelFile : (e)->
			console.log("cancelFile")
			ele = $(e.target).parents(st.item)
			key = ele.index()
			ele.remove()
			Sb.trigger("files:del", key)
			e.preventDefault()
			return	
	}
	fn = {
		prepare_data : (files)->
			index = 0
			while index <  files.length
				file = files[index]
				Sb.trigger("file_reader:setFile", file, image, fn.setFileImage)
				index++
			return

		setFileImage : (file, image)->
			Sb.trigger("underscore:template", st.tpl, image, fn.getMergeData)			
			Sb.trigger("files:add", file)
			return

		getMergeData : (html)->
			dom.preview.append(html)
			item = dom.preview.find(st.item)
			
			$("<span></span>", 
				class : "cancel"
				click : events.cancelFile
			).appendTo(item)
			
			return
	}
	initialize = (opts) ->
		st = $.extend({}, defaults, opts)
		catchDom(st)
		suscribeEvents()
		return

	return {
		init: initialize
	}

###
Modulo que realiza el submit 
@class modules
@main /home/jhonnatan/htdocs/skeletor/app/precom/coffee
@author 
###	

yOSON.AppCore.addModule "submit_images", (Sb) ->
	defaults = {
		parent 	: "form"
		el 		: ".submit"
	}
	st = {}
	dom = {}

	catchDom = () ->
		dom.parent 	= $(st.parent)
		dom.el 		= $(st.el, dom.parent)
		return
	suscribeEvents = () ->
		dom.el.on "submit", events.submit
		return

	events = {
		submit : (e) ->
			return
	}
	fn = {
		functionName : () ->
			console.log("example")
			return
	}
	initialize = (opts) ->
		st = $.extend({}, defaults, opts)
		catchDom()
		suscribeEvents()
		return

	return {
		init: initialize
	}