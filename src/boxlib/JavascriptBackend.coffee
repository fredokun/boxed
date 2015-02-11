##
#The backend that treat the javacripts Boxes.
##

class window.JavascriptBackend extends Backend

        constructor : ->
                super

        #
        compile: (box) ->
                controlMeta = box.getControlMetaData();
                if( controlMeta.display is "view" )
                        controlMeta.contentType = "type/text"
