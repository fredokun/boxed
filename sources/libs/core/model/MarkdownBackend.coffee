define(['Box','Presentor','Backend','commonmark'],((Box,Presentor,Backend,commonmark)->

	class MarkdownBackend extends Backend

		constructor : (presentors) ->
			super(presentors)
			# Creating a markdown parser transforming the code ast tree
            @parser = new commonmark.Parser()
            # Creating a translator transforming an ast tree to html code.
            @writer = new commonmark.HtmlRenderer()

		chew : (box) ->
			content = ""

			if box.getMode() is "edit_content"
				box.setMode("view")
				content = @writer.render( @parser.parse( box.getContent() ) )
			else
				if box.getMode() is "view"
					box.setMode("edit_content")
					content = box.getContent()

			data =
				action : "commit"
				content : content
				idBox : box.getId()

			this.notifyPresentors(data)

	return MarkdownBackend
));