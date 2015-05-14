##
# The class representing a box Markdown content.
##
define(["DocumentBox"],((DocumentBox) ->

  #@class[MarkdownBox]
  #@service[MarkdownBox]
  class MarkdownBox extends DocumentBox

    #@constructor[init] : id -> [DocumentBox]
    #@method[MarkdownBox]: Build a Markdown type box.
    #@arg[id][String]: The unique identifier of the box.
    #@return[MarkdownBox]: The newly created box.
    constructor : (id) ->
      super(id)

    #@observator[getType] : [CodeBox] -> String
    #@method[getType] : Method that returns the type of the box.
    #@return[String] : The type of the box.
    getType : ->
      return "MARKDOWN"

    #@operator[exportJSON] -> [JSONObject]
    #@method[exportJSON]: Method that returns the value of the document in JSON format.
    #@return[JSONObject]: The box in JSON format.
    exportJSON: ->
      myBox = 
        id : @id
        content : @content
        mode : @mode
        userMetaData : @userMetaData
        type: "MARKDOWN"

      return myBox
            
  return MarkdownBox
))
