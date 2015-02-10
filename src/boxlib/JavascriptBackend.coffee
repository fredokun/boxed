##
#The backend that treat the javacripts Boxes.
##

class window.JavascriptBackend extends Backend

        constructor : ->
                console.log('Javascript')
                super

        #
        compile: (box) ->
                controlMeta = box.getControlMetaData();
                if( controlMeta.display is "view" )
                        controlMeta.contentType = "type/text"
