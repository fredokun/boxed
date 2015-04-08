##
#
##

define(["DocumentBox"],((DocumentBox) ->

        ##service:MarkdownBackend
        #@class:MarkdownBox
        class MarkdownBox extends DocumentBox

                ##contructor[init] : String -> [MarkdownBox]
                #@method[MarkdownBox] : Create a Markdown Box type.
                #@param[id][String] : The Box id.
                constructor : (id) ->
                        super("#{id}")

                ##observator[getType] : [Box] -> String
                ##invariant[getType()] : getType() = "MARKDOWN"
                #@method[getType] : Override method that return the value of the class parameter 'type'.
                #@return[String] : The type's value.
                getType: ->
                        return "MARKDOWN"

        return MarkdownBox
        
))
