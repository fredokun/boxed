###
# Box
# Class that represent a Box.
###

define([],(() ->

        class Box 

                # @method constructor : 
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

                

                # OBSERVATORS OF THE BOX
                # method setContent :
                # arg value :
                setContent : (newContent) ->
                        @content = newContent
        
                # Method that get the id of the Box.
                getId : ->
                        @id

                getControlMetaData: ->
                        @controlMetaData
        
        return Box

))
