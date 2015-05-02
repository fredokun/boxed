##
# Error Class indicating a unique identifier already in use.
##

define([],(()->

  #@service[BoxNotfound]
  #@method[BoxNotfound]
  class BoxNotfound

    #@service[BoxNotfound]
    #@method[BoxNotfound]
    #@arg[object]:The name of the object that caused the error.
    #@arg[function]:The name of the the function that caused the error.
    constructor: (@object,@function,@id) ->
      #@param[object][String]:The name of the object that caused the error.
      #@param[function][String]:The name of the the function that caused the error.
      #@param[id][String]: The id of the box not found.

    #@operator[toSTring] : [notDefine] -> String
    #@method[toString] : Method returning the message corresponding to the error.
    #@return[String]: The error message for this error.
    toString : ->
      return "The box '#{id}' in #{@function} in #{@object} was not found."

  return BoxNotfound
))