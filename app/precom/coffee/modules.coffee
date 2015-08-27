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
Module description
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

	catchDom = (st) ->
		dom.form 	= $(st.form)
		dom.input 	= $(st.input, dom.form)        
		return

	suscribeEvents = () ->
		dom.input.on "change",   events.selectedFiles
		return

	events = {
		selectedFiles : (e) ->
			
			files = e.target.files

					

			reader = new FileReader()
			reader.onload = (e)->
				result = 
					data : 
						images : []
				Sb.trigger("underscore:template", st.tpl, result, (html)-> 
					
					return
				)
				return

			return
	}
	fn = {
		functionName : () ->
			console.log("example")
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
, ["../bower_components/underscore/underscore.js"]