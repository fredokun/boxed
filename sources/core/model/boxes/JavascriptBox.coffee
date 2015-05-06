##
# 
##
define(["CodeBox"],((CodeBox)->

    #@class[JavascriptBox]
    #@service[JavascritpBox]
    class JavascriptBox extends CodeBox

        #@constructor[init] : id -> [JavascriptBox]
        #@method[JavascriptBox]: Build a Javascript type box.
        #@arg[id][String]: The unique identifier of the box.
        #@return[JavascriptBox]: The newly created box.
        constructor : (id) ->
            super(id)

        #@observator[getType] : [CodeBox] -> String
        #@method[getType] : Method that returns the type of the box.
        #@return[String] : The type of the box.
        getType : ->
            return "JAVASCRIPT"

        exportJSON: ->
            myBox = 
                id : @id
                content : @content
                mode : @mode
                userMetaData : @userMetaData
                type: "JAVASCRIPT"

            console.log myBox

            return myBox

    return JavascriptBox
))