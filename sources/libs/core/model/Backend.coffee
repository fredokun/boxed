define(['Box','Presentor'],((Box,Presentor)->

	class Backend

		constructor : (@presentors) ->

		chew : (box) ->
			console.log "Error method chew not implemented."
			throw Error()

		notifyPresentors : (datas) ->
			presentor.preventPresentor(datas) for presentor in @presentors

	return Backend
));