##
#
##

define([],(() ->
        
        ##service[Box]
        #@class[Box]
        class Box
                
                ##contructor[init] : [id] -> [Box]
                #@method[Box] : Method creator of Box.
                #@arg[id][String] : The identifier of the Box.
                constructor: (@id) ->
                       #@param[id][String] : The identifier of the Box.
                       #@param[mode][String] : The mode of the Box.
                        @mode = "EDITABLE"

                        #@param[content][String] : Text contents in the box.
                        @content = ""

                        #@param[userMetaData][JSONObject] : An object that contains the meta user datas.
                        @userMetaData = {}


                ##operation[setMode] : [Box] x String -> [Box]
                ##pre[setMode(m)] : m = "COMMIT" or m = "EDITABLE"
                #@method[setMode] : Method that sets the value of the class parameter 'mode'.
                #@arg[mode][String] : The new box's mode.
                setMode: (mode) ->
                        switch mode
                                when "COMMIT", "EDITABLE", "EDIT_USER_META" then @mode = mode
                                else console.log "[:(] Mode not managed... [):]"
                
                ##operation[setUserMetaData] : [Box] x JSONObject -> [Box]
                #@method[setUserMetaData] : Set the value of the attribute class userMetadata.
                setUserMetaData : (myJson) ->
                        @userMetaData = myJson                         

                ##operation[setContent] : [Box] x String -> [Box]
                #@method[setContent] : Method that sets the value of the class parameter 'content'.
                #@param[content][string] : The new content's value.
                setContent: (content) ->
                        @content = content 

                ##observator[getMode] : [Box] -> String
                ##invariant[getMode()] : getMode() = "COMMIT" or getMode() = "EDITABLE"
                #@method[getMode] : Method that return the value of the class parameter 'mode'.
                #@return[String] : The mode's value.
                getMode: ->
                        @mode

                ##observator[getContent] : [Box] -> String
                #@method[getContent] : Method that return the value of the class parameter 'content'.
                #@return[String] : The content's value.
                getContent: ->
                        @content

                ##observator[getId] : [Box] -> String
                #@method[getId] : Method the return the value of the class parameter 'id' ;
                #@return[String] : String representing the value of the attribute class Box.
                getId: ->
                        @id

                ##observator[getUserMetaData] : [Box] -> JSONObject
                #@method[getuserMetaData] : Teyure the value of the class attribute : userMetaData.
                #@return[JSONObjet] : The value of the class attribute userMetaData.
                getUserMetaData : ->
                        @userMetaData

                ##observator[isCodable] : [Box] -> boolean
                #@method[isCodable] : Method signaling if the box is a CodeBox.
                #@return[boolean] : True if it is a CodeBox, false else.
                isCodable : ->
                        false

        return Box
))
