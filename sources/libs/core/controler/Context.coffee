define(['Document'],((Document) ->

	class Context 

		contructor : (docName,presentor) ->
			@doc = new Document(docName,presentor)

		addBox : (type) ->
			@doc.addBox(type)

		deleteBox : (id) ->
			@doc.deleteBox(id)

		addBoxBefore : (id,type) ->
			@doc.addBoxBefore(id,type)

		addBoxAfter : (id,type) ->
			@doc.addBoxAfter(id,type)

		getBox : (id) ->
			@doc.getBox(id) 

	return Context

))