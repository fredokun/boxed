##
#
##

define(["Box"],((Box) ->
        
        ##service[Box]
        #@class[Box]
        class DocumentBox extends Box
                
                ##contructor[init] : [id] -> [Box]
                #@method[DocumentBox] : Method creator of an DocumentBox.
                #@arg[id] : The identifier of the Box.
                constructor: (id) ->
                        super("#{id}")

                ##observator[getType] : [Box] -> String
                #@method[getType] : Abstract method that return the value of the class parameter 'type'.
                #@return[String] : The type's value.
                getType: ->
                        console.log "[:(] Error! Method getType is not been override... [):]"
                        return null

        return DocumentBox
))
