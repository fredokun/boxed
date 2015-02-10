##
#
#(Abstract) class that represent a Backend.
#
##

class window.Backend extends BoxAdministrator

        #This method sens a error. It must be implemented by the backend languaage and be adapt to this.
        compile: (box) ->
                throw Error ;

        #Method that change the mode of the box.
        changeMode : (idBox,mode) ->
                box = getBox(idBox)

                switch mode
                        when 0 
                                box.setMode(mode);
                                boxMeta = box.getControlMetaData()
                                boxMeta['display'] = "view"

                        when 4 
                                box.setMode(mode);
                                boxMeta = box.getControlMetaData()
                                boxMeta['display'] = "edit"
        
