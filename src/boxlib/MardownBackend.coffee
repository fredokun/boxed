##
#The backend that treat the Markdown Boxes.
##

class MarkdownBackend extends Backend

        #
        compile: (box) ->
                controlMeta = box.getControlMetaData();
                if( controlMeta.display is "view" )
                        controlMeta.contentType = "type/text;type/html"
