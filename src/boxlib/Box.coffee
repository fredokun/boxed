###
#
# Boxlib #
#
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
                @controlMetaData

        #Getter of the attribute 'boxType'.
        getBoxType : ->
                @boxType

        #Getter of the attribute 'boxMode'.
        getBoxMode : ->
                return @boxMode

        
