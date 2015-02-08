###
#
# Boxlib #
# The library about Boxed' boxes.
#
###

class Box 
        
        #The box constructor takes
        constructor : (@id) -> 
                @content = ""                     #The box content.
                @userMetaData = {}                #
                @controlMetaData = {}             #
                @boxType = BoxType.JAVASCRIPT     #The Type of the Box: Automatically it's a javascript box.
                @boxMode = BoxMode.EDIT_CONTENT   #The Mode of the Box: Automatically, the box is on mode editable.

        #Getter of the attribute 'id'.
        getId : ->
                @id

        #Getter of the attribute 'content'.
        getContent : ->
                @content

        #Getter of the attribute 'userMetaData'.
        getUserMetaData : ->
                @userMetaData

        #Getter of the attribute 'controlMetaData'.
        getControlMetaData : ->
                @controlMetaData

        #Getter of the type of the box.
        getBoxType : ->
                @boxType

        #Getter of the mode of the box.
        getBoxMode : ->
                @boxMode

        #Setter of the content
        setContent : (nContent) ->
                @content = nContent 
        
        #Setter of the attribute 'userMetaData'.
        setUserMetaData : (nMeta) ->
                @userMetaData = nMeta

        #Setter of the attribute 'controleMetaData'.
        setControlMetaData : (nMeta) ->
                @controlMetaData = nMeta
        
        #Set the type of the box.
        setBoxType : (type) ->
                #If the type exists then change the type... 
                index = isTyped(type)
                if index > -1 then @boxType = index
                else throw error

        #Set the mode of the box.
        setBoxMode : (mode) ->
                #If the mode exists the change the mode...  index =
                index = isModed(mode)
                if index < -1 then @boxMode = index
                else throw error
        
module.exports = Box

        

        
