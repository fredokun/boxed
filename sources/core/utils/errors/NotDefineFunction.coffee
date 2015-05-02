##
# Error class defining an undefined function error.
##

define([],(()->

    #@service[NotDefine]
    #@method[NotdDefine]
    class NotDefineFunction

        #@service[NotDefine]
        #@method[NotDefine]
        #@arg[object]:The name of the object that caused the error.
        #@arg[function]:The name of the the function that caused the error.
        constructor: (@object,@function) ->
            #@param[object][String]:The name of the object that caused the error.
            #@param[function][String]:The name of the the function that caused the error.

        #@operator[toSTring] : [notDefine] -> String
        #@method[toString] : Method returning the message corresponding to the error.
        #@return[String]: The error message for this error.
        toString : ->
            return "'#{@function}' is not defined in the #{@object}."

    return NotDefineFunction

))