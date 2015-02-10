##
#
#(Abstract) class that represent a Backend.
#
##

class window.Backend extends BoxAdministrator

        constructor : () ->
                super

        #This method sens a error. It must be implemented by the backend languaage and be adapt to this.
        compile : (idBox) ->
              console.log('compile');  
