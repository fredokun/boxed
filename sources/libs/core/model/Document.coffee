define(['Box','Presentor'],((Box,Presentor) ->

	class Document


		constructor : (@name,@presentors) ->
			@currentBox = null
			@boxSelect = null  
			@boxes = []
			@boxesHash = []

			@userMetadata = {}
			@controlMetaData = {}

			id = 0
			@oldIds = []

		getBox : (id) ->
			index = this.getBoxIndex(id)
			return box[index]

		getId : ->
			if @oldIds.length > 0 then return @oldIds.shift()
			save = id 
			id++ ;
			return save

		addBox : (type) ->
			box = new Box(this.getId(),type) 
			@boxes.push(box)
			@boxesHash[(@boxes.length-1)] = box

			data = 
				action : "ADD_END"
				box : box

			this.update(data)

		addBoxAfter : (id,type) ->
			index = this.getBoxIndex(id)
			box = new Box(this.getId(),type) 
			@boxes.splice( index+1, 0, box )
			
			this.ordonanceHash(index)

			data = 
				action : "ADD_AFT"
				box : box

			this.update(data)

		addBoxBefore : (id,type) ->
			index = this.getBoxIndex(id)
			box = new Box(this.getId(),type) 
			@boxes.splice( index, 0, box )
			
			this.ordonanceHash(index)

			data = 
				action : "ADD_BEF"
				box : box

			this.update(data)


		deleteBox : (id) ->
			index = this.getBoxIndex(id)
			@boxes.splice(index+1,1)

			this.ordonanceHash(index)

			data = 
				action : "DEL_BOX"
				box_id : id

			this.update(data)


		# Private and abstract methods of the class 'Document'.
		update : (data) ->
		 	presentor.preventPresentor(data) for presentor in @presentors

		ordonanceHash : (index) ->
			@boxesHash["#{@boxes[i].getId()}"] = i for i in [index..(@boxes.length-1)]	

		getBoxIndex : (id) ->
			if ! ("#{id}" in @boxesHash) then 
				console.log "Box do not exist in the model. (document)"
				throw error
			else return @boxesHash["#{id}"]

	return Document

))