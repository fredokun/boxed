###
# Box
# Class representing a box.
###

define([],(() ->

        class Box 

                # @method constructor : Constructor for constructing a box.
                # @arg @id : The id of the Box.
                # @arg @type : The type of the Box (it can be MARKDOWN, JAVASCRIPT, for now)
                constructor : (@id,@type) ->

                        # @content : The content of the Box.
                        @content = ""

                        # @mode : The mode of the Box.
                        @mode = "EDITABLE"

                        # @userMetaData
                        @userMetaData = {}

                        # @controlMetaData
                        @controlMetaData = 
                                mime : @type
                                display : "EDITABLE"
                                values : @content

                

                # OBSERVERS OF THE BOX
        
                # @method getId : Method that get the id of the Box.
                getId : ->
                        @id

                # @method getControlMetaData : Method retrieving the identifier of the box .
                getControlMetaData: ->
                        @controlMetaData
        
                # @method getContent : Method retrieving the contents of the box.
                getContent : ->
                        @content

                # @method getType : Method retrieving the contents of the box.
                getType : ->
                        @type



                # THE OPERATIONS OF THE BOX 

                # @method setContent :
                # @arg newContent : The new contents of the box
                setContent : (newContent) ->
                        @content = newContent

                # @method setControlMetaData :
                # @arg newMeta :
                setControlMetaData : (newMeta) ->
                        @controlMetaData = newMeta
        
        return Box

))
