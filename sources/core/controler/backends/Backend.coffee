##
# Class defining the architecture of a backend.
##
define([],(()->
  #@service[Backend]
  #@class[Backend]
  class Backend

    #@contructor[init]: -> [Backend]
    #@Backend: Method building a backend object type.
    #@return: The newly built backend.
    constructor: ->

    #@operator[chew]: [Backend] x [Box] -> [JSONObject]
    #@method[chew]: Method taking a box and returning the contents of the box 'compiled'.
    #@return[JSONObject]: The contents of the compiled box.
    chew: (box) ->
      throw new Error("Method not define. You must extend Backend.")

  return Backend
))
