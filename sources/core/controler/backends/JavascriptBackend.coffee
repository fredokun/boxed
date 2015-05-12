##
# Class defining a javascript type of backend.
##
define(["Backend"],((Backend)->
    #@service[MarkdownBackend]
    #@class[MarkdownBackend]
    class JavasciptBackend extends Backend

        #@contructor[init]: -> [MarkdownBackend]
        #@MarkdownBackend: Method building a backend object type.
        #@return: The newly built backend.
        constructor: ->
            super()

        #@operator[chew]: [MarkdownBackend] x [Box] -> [JSONObject]
        #@method[chew]: Method taking a box and returning the contents of the box 'compiled' in Java.
        #@arg[box][Box]: The box to compile.
        #@return[JSONObject]: The contents of the compiled box.
        chew: (box) ->
            result = ""
            console.log = (message) ->
                result = "#{result}#{message}<br/>"

            try
                result = eval(box.getContent())
            catch e
                result = "<h2 class='errorMessage'>Viewing impossible. Errors in the code.</h2>"

            theReturn =
                id : box.getId()
                type : "CODE"
                content : box.getContent()
                result : result
                mime : "javascript"
                mode : box.getMode()
            
            return theReturn

    return JavasciptBackend
))