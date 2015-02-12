###
#
# Boxlib #
# The library about Boxed' boxes.
#
###

(($) ->
) jQuery

class window.Box 
        
        #The box constructor takes
        constructor : (@id, @callback) -> 
                @content = ""                     #The box content.
                @userMetaData = {}                #
                @controlMetaData = {}             #
                @boxType = BoxType.JAVASCRIPT     #The Type of the Box: Automatically it's a javascript box.
                @boxMode = BoxMode.EDIT_CONTENT   #The Mode of the Box: Automatically, the box is on mode editable.
                @currentBox = null
                info =
                        action : "DRAW_BOX_END"
                        id : @id
                        boxType : "JAVASCRIPT"
                        
                @callback.fire(info)

        #Getter of the attribute 'id'.
        getId : ->
                @id

        #Box is Selected, it triggered the controler
        getSelected : ->
                info =
                        action : "SELECT_BOX"
                        id : @id
                @callback.fire(info)


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
                

        

        
