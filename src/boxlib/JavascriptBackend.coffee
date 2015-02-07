##
#The backend that treat the javacripts Boxes.
##

class JavascriptBackend extends Backend

        #
        compile: (box) ->
                controlMeta = box.getControlMetaData();
                if( controlMeta.display is "view" )
                        controlMeta.contentType = "type/text"
