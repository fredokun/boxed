##
# Class representative of a Model Code box.
##
define(["Box"],((Box) ->

  #@service[CodeBox]
  #@refine[Box]
  #@class[CodeBode]
  class CodeBox extends Box

    #@constructor[init] : String -> [CodeBox]
    #@method[CodeBox] : Method constructing a model code box.
    #@arg[id][String] : The unique id of the box.
    constructor : (id) ->
      super(id)

  return CodeBox

))