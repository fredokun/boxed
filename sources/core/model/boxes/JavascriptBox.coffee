##
#
##

define(["CodeBox"],((CodeBox) ->
        
        ##Service[JavascriptBox]
        #@class[JavascriptBox]
        class JavascriptBox extends CodeBox

                ##constructor[init] : id -> [JavascriptBox]
                #@method[JavascriptBox] : Method that creates a new Box that can contains Javascript.
                #@arg[id][String] : The id of the Box.
                constructor: (id) ->
                        super("#{id}")

                ##observator[getType] : [Box] -> String
                #@method[getType] : Abstract method that return the value of the class parameter 'type'.
                #@return[String] : The type's value.
                getType: ->
                        return "JAVASCRIPT"

        return JavascriptBox 
))
