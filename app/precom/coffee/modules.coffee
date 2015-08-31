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
, ["../bower_components/underscore/underscore.js"]


###
Validacion de FileReader
@class underscore
@main flux/all
@author Juan Pablo
###
yOSON.AppCore.addModule "file_reader", (Sb) ->
	
	fn =
		setFile : (result, callback)->
			if (window.File && window.FileReader && window.FileList && window.Blob)
				reader = new FileReader()
				reader.onload = (e)->
					fn.loadReader(e, callback)
					return
				reader.readAsDataURL()
			return

		loadReader : (e, callback) ->			
			result.data.images["src"] = e.target.result
			callback(result)
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
		preview 	: ""
		input		: ""
	}
	
	st = {}
	dom = {}

	result = data: images: []

	catchDom = (st) ->
		dom.form 	= $(st.form)
		dom.input 	= $(st.input, dom.form)
		dom.preview = $(st.preview, dom.form)     
		return

	suscribeEvents = () ->
		dom.input.on "change",   events.selectedFiles
		return

	events = {		
		selectedFiles : (e)->
			fn.prepare_data(e.target.files)			
			return		
	}
	fn = {
		prepare_data : (files)->			
			i = 0
			while i <  files.length
				file = files[i]
				
				result.data.images['title'] = escape(files.name)				
				Sb.trigger("file_reader:setFile", file, fn.setFileImage)
				i++
			
			Sb.trigger("underscore:template", st.preview, result, fn.getMergeData)			
			return

		setFileImage : (resultFileReader)->
			result = resultFileReader
			return

		getMergeData : (html)->
			dom.preview.html(html)
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