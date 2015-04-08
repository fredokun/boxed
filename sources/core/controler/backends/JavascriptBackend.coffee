##
#
##

define(["Backend"],((Backend) ->

        ##service[JavscriptBackend]
        #@class[JavascriptBackend]
        class JavascriptBackend extends Backend
        
                ##constructor[init] : -> [JavacscriptBackend]
                #@method[JavascriptBackend] :  Javascript backend cosntructor.
                constructor : ->
                        super() 

                ##operator[chew] : [Backend] x [Box] -> JSONobjet
                #@method[chew] : Abstract method, takes a Box and return a JSON Object of the Box compile.
                #@arg[box][Box] : The box to 'compile'.
                #@return[JSONobject] : An object with the compile box content.
                chew : (box) ->
                        result = ""
                        oldLog = console.log
                        console.log = (message) ->
                                result = "#{result}#{message}<br/>"

                        try
                                result = eval(box.getContent())
                        catch e
                                result = "<h2>Error in compilation!</h2>"

                        return result

        return JavascriptBackend
                                
)) 
