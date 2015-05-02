##
# Error class defining an undefined object error.
##

define([],(()->

  #@service[NotDefine]
  #@method[NotdDefine]
  class NotDefineObject

    #@service[NotDefine]
    #@method[NotDefine]
    #@arg[object]:The name of the object that caused the error.
    #@arg[function]:The name of the the function that caused the error.
    constructor: (@object,@function,@type) ->
      #@param[object][String]:The name of the object that caused the error.
      #@param[function][String]:The name of the the function that caused the error.
      #@param[type][String]: The type of the unknown object.

    #@operator[toSTring] : [notDefine] -> String
    #@method[toString] : Method returning the message corresponding to the error.
    #@return[String]: The error message for this error.
    toString : ->
      return "'#{object}' is not defined in the #{@function} function in the class #{object}."

  return NotDefineObject

))