##
#
##

define(["Box"],((Box) ->

        ##Service[CodeBox]
        #@class[CodeBox]
        class CodeBox extends Box

                ##constructor[init] : id -> [Box]
                #@method[CodeBox] : Method that create a box for code.
                ##arg[id] : The identifier of the box.
                constructor : (id) ->
                        super("#{id}") 
                        #@param[result][String] : The result of the content box.
                        @result = "" 

                ##observator[getType] : [Box] -> String
                #@method[getType] : Abstract method that return the value of the class parameter 'type'.
                #@return[String] : The type's value.
                getType: ->
                        console.log "[:(] Error! Method getType is not been override... [):]"
                        return null

                ##observator[getResult] : [CodeBox] -> String
                #@method[getResult] : Method that return the attribute class result.
                #@return[String] : The value of attrubite class result.
                getResult : ->
                        @result 

                ##operation[setResult] : [CodeBox] x String -> [CodeBox] 
                #@method[setResult] : Set the value of the result Box.
                #@arg[result][String] : The new value of the attribute class 'result'.
                setResult : (result) ->
                        @result = result 

                ##observator[isCodable] : [Box] -> boolean
                #@method[isCodable] : Method signaling if the box is a CodeBox.
                #@return[boolean] : True if it is a CodeBox, false else.
                isCodable : ->
                        true

        return CodeBox
))
