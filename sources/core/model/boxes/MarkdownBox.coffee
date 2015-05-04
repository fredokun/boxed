##
# The class representing a box Markdown content.
##
define(["DocumentBox"],((DocumentBox) ->

    #@class[MarkdownBox]
    #@service[MarkdownBox]
    class MarkdownBox extends DocumentBox

        #@constructor[init] : id -> [DocumentBox]
        #@method[MarkdownBox]: Build a Markdown type box.
        #@arg[id][String]: The unique identifier of the box.
        #@return[MarkdownBox]: The newly created box.
        constructor : (id) ->
            super(id)

        #@observator[getType] : [CodeBox] -> String
        #@method[getType] : Method that returns the type of the box.
        #@return[String] : The type of the box.
        getType : ->
            return "MARKDOWN"

        exportJSON: ->
            result = super
            type = "MARKDOWN"
            
    return MarkdownBox
))