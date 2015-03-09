define(['BoxType','BoxMode'],((BoxType,BoxMode) ->

	class Box

		constructor : (@id,type) ->
			@userMetaData = {}
			@controlMetaData = {}

			@content = "" 

			@type = BoxType.getType(type)
			@mode = BoxMode.getMode("EDIT_CONTENT")

		getId : (id) ->
			@id

		getType : ->
			@type

	return Box
	
))