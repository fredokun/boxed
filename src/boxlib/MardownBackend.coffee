##
#The backend that treat the Markdown Boxes.
##

class window.MarkdownBackend extends Backend

      constructor: ->
      		   super

        #
        compile: (box) ->
                controlMeta = box.getControlMetaData();
                if( controlMeta.display is "view" )
                        controlMeta.contentType = "type/text;type/html"
