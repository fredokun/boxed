define(['Context'],((Context) ->

	# Question? did the presentor know the Backend?

	class Presentor 

		contructor : (@context) ->

		preventPresentor : (datas) ->
			switch datas['action']
				when "ADD_END" then

					box = this.createBox(datas['box'])
					# chew the bow by a backend.
					this.addBoxPage(box) ;

				when "ADD_BEF", "ADD_AFT" then

					box = this.createBox(datas['box'])
					# chew the bow by a backend.
					this.addBoxPositioned(box,data) ;

				when "DEL_BOX" then
					this.deleteBox(datas['box_id']) ;					

		# Private and abstract methods of the class ' Presentor'.
		createBox : (box) ->
			console.log("Method not implemented! (createBox)")
			throw error

		addBoxPage : (box) ->
			console.log("Method not implemented! (addBoxPage)")
			throw error

		addBoxPositioned : (box,dataPosition) ->
			console.log "Method not implemented! (addBoxPositioned)" 
			throw error

		deleteBox : (idBox) ->
			console.log "Method not implemented! (deleteBox)"
			throw error

	return Presentor

))