##
# Class defining a publishing type paper box.
##
define(["Box"],((Box) ->

  #@service[DocumentBox]
  #@class[DocumentBox]
  class DocumentBox extends Box

    #@constructor[init]: int -> [DocumentBox]
    #@method[DocumentBox] : Method constructing a document type box.
    #@arg[id][String]: The unique identifier of the box.
    #@return[DocumentBox] : The newly created box.
    constructor: (id) ->
      super(id)

  return DocumentBox
))