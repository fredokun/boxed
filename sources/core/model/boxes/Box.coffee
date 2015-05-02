##
# Class representing a 'Box' editing.
##
define(["NotDefineFunction","NotDefineObject"],((NotDefineFunction,NotDefineObject) ->

  #@service[Box]
  #@class[Box]
  class Box

    #@constructor[Box][init] : -> [Box]
    #@method[Box][Box] : Method creating a doubly linked list item.
    #@arg[Box][id][String] : The unique identifier of the box.
    #@return[Box] : A newly created empty box.
    constructor : (@id) ->
      #@param[id][String] : The unique identifier of the box.
      #@param[content][String] : Contained in the box.
      @content = "" 

      #param[userMetaData][JSONObject] : The metadata of the box.
      @userMetaData = {}

      #param[mode][String] : The display mode of the box.
      @mode = "EDIT_CONTENT"

    #@observator[Box][getId] : [Box] -> String
    #@method[Box][getId] : Class method that returns the value of 'id' attribute.
    #@return[String] : The value of the identifier of the box.
    getId : -> 
      @id

    #@observator[getContent] : [Box] -> String
    #@method[getContent] : Class method that returns the value of 'content' attribute.
    #@return[String] : The value of the content of the box.
    getContent : -> 
      @content

    #@observator[getMode] : [Box] -> String
    #@method[getMode] : Class method that returns the value of 'mode' attribute.
    #@return[String] : The value of the content of the box.
    getMode : -> 
      @mode

    #@observator[getUserMetaData] : [Box] -> String
    #@method[getUserMetaData] : Class method that sets the value of 'userMetaData' attribute.
    #@param[data][String] : Set the value of the attribute mode.
    getUserMetaData : -> 
      @userMetaData

    #@observator[Box][setId] : [Box] -> String
    #@method[Box][setId] : Class method that sets the value of 'id' attribute.
    #@param[data][String] : Set the value of the attribute 'id'.
    setId : (data) -> 
      @id = data

    #@observator[setContent] : [Box] -> String
    #@method[setContent] : Class method that sets the value of 'content' attribute.
    #@param[data][String] : Set the value of the attribute 'content'.
    setContent : (data) -> 
      @content = data

    #@observator[setMode] : [Box] -> String
    ##@pre setMode(B,m) require m = EDIT_CONTENT or m = COMMIT or m = EDIT_USER_META
    #@method[setMode] : Class method that sets the value of 'mode' attribute.
    #@param[    data][String] : Set the value of the attribute 'mode'.
    setMode : (data) -> 
      switch data
        when "EDIT_CONTENT", "COMMIT", "EDIT_USER_META" then @mode = data
        else throw new NotDefineObject("Box","setMode",data)

    #@observator[setUserMetaData] : [Box] -> String
    #@method[setUserMetaData] : Class method that sets the value of 'userMetaData' attribute.
    #@param[data][JSONObject] : Set the value of the attribute 'userMetaData'.
    setUserMetaData : (data) -> 
      @userMetaData = data

    #@observator[getType] : [CodeBox] -> String
    #@method[getType] : Method that returns the type of the box.
    #@return[String] : The type of the box.
    getType : ->
      throw new NotDefineFunction("Box","getType")

    #@operator[toString] : [Box] -> [Box]
    #@method[toString] : Method printing on the standard output value of the object.
    toString : ->
      console.log this

  return Box

))