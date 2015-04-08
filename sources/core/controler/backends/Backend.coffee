##
#
##

define([],(() ->

        ##service[Backend]
        #@class[Backend] :
        class Backend

                ##constructor[Backend] : -> [Backend]
                #@method[Backend] : Creates a new backend.
                constructor: ->
                        

                ##operator[chew] : [Backend] x [Box] -> JSONobjet
                #@method[chew] : Abstract method, takes a Box and return a JSON Object of the Box compile.
                #@arg[box][Box] : The box to 'compile'.
                #@return[JSONobject] : An object with the compile box content and its mime.
                chew : (box) ->
                        console.log "[:(] Error! This Backend didn't chew! [):]"
                        return null

        return Backend
))
