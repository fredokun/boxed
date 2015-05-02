##
# Error Class indicating a unique identifier already in use.
##

define([],(()->

  #@service[NotDefine]
  #@method[NotdDefine]
  class NotDefineObject

    #@service[NotDefine]
    #@method[NotDefine]
    #@arg[object]:The name of the object that caused the error.
    #@arg[function]:The name of the the function that caused the error.
    constructor: (@object,@function,@id) ->
      #@param[object][String]:The name of the object that caused the error.
      #@param[function][String]:The name of the the function that caused the error.
      #@param[type][String]: The type of the unknown object.

    #@operator[toSTring] : [notDefine] -> String
    #@method[toString] : Method returning the message corresponding to the error.
    #@return[String]: The error message for this error.
    toString : ->
      return "'#{@id}' in #{@function} in #{@object} is already used."

  return NotDefineObject

))