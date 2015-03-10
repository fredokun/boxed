##
# Backend class representing a controlling markdown type boxes.
##

define(['Backend','commonmark'],((Backend,commonmark) ->
        
        #
        class MarkdownBackend extends Backend

                # @method constructor : Method to build a markdown type of backend.
                # @arg @callback : The method inheriting from the class Backend , the 'callback' argument is necessary to the creation of its parent.
                constructor : (callback) ->
                        super(callback)
                        # Creating a markdown parser transforming the code ast tree
                        @parser = new commonmark.Parser()
                        # Creating a translator transforming an ast tree to html code.
                        @writer = new commonmark.HtmlRenderer()

                        
                # @method chomp : Method inherited from its parent class , it allows transfomer the contents of the box in parsed content and vice versa.
                # @arg box : The box that must compile / decompile content.
                chomp : (box) ->

                        data = box.getControlMetaData()

                        if data.display is "COMPILE"

                                newContent = 
                                        display : "EDITABLE"
                                        values : box.getContent()
                                        mime : 'text/html'

                                box.setControlMetaData(newContent)

                        else

                                newContent = 
                                        display : "COMPILE"
                                        values : @writer.render( @parser.parse( box.getContent() ) )
                                        mime : 'text/html'

                                box.setControlMetaData(newContent)

                        info = 
                                command : "UPDATE_USER_BOX"
                                box : box

                        # Calling the update callback model.
                        @callback.emitEvent('modelUpdapted',[info])

        return MarkdownBackend

))
