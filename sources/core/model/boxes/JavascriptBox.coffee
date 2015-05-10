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
        
        #@operator[exportJSON] -> [JSONObject]
        #@method[exportJSON]: Method that returns the value of the document in JSON format.
        #@return[JSONObject]: The box in JSON format.
        exportJSON: ->
            myBox = 
                id : @id
                content : @content
                mode : @mode
                userMetaData : @userMetaData
                type: "JAVASCRIPT"

            return myBox

    return JavascriptBox
))
