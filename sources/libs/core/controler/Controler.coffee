define(['Context','Presentor1','MarkdownBackend','JavascriptBackend'],((Context,Presentor1,MarkdownBackend,JavascriptBackend) ->

	class Controler 

		constructor : ->
			@presentors = []
			@backends = []
			@context = new Context("newDoc",@presentors) 

			@presentors.push(@presentor1);

			for key, value in BoxType.BOX_TYPE
				switch value
					when "markdown" then @backends[ value ] = new Markdownbackend(@presentors)
					when "javascript" then @backends[ value ] = new Markdownbackend(@presentors)
					else
						console.log "Error backend doesn't exists" 
						throw Error

		AddBoxEnd : (type) ->
			@context.addBox(type)

		DeleteBox : (id) ->
			@context.deleteBox(id)

		AddBoxBefore : (id,type) ->
			@context.addBoxBefore(id,type)

		AddBoxAfter : (id,type) -> 
			@context.addBoxAfter(id,type)

		Comit : (id) ->
			box = @context.getBox(id)
			backend = this.getBackend(box.getType())

			backend.chew(box)

		# Private and abstract methods of the class 'Controler'.
		getBackend : (type) ->
			@backends[type]

	return Controler

)) 