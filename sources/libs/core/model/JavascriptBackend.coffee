define(['Box','Presentor','Backend'],((Box,Presentor,Backend)->

	class JavascriptBackend extends Backend

		constructor : (presentors) ->
			super(presentors)

		chew : (box) ->
			content = ""

			if box.getMode() is "edit_content"
				box.setMode("view")
				content = eval(box.getContent())
			else
				if box.getMode() is "view"
					box.setMode("edit_content")
					content = box.getContent()


			content = eval(box.getContent())
			data =
				action : "commit"
				content : content
				idBox : box.getId()

			this.notifyPresentors(data)

	return MarkdownBackend

));