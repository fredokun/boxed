# a preliminary and dirty box framework

BoxLib = {}
@BoxLib = BoxLib

BoxLib.buildBox = (kind, id) ->
          switch kind
                  when "markdown" then new BoxLib.MarkdownBox(id)

                  else
                      console.log("Unsupported box kind: #{kind}")
                      null

class BoxLib.BoxEd
    constructor: () ->
        @boxes = []   # no box initially
        @boxMap = {}
        @selectedBox = -1  # no selection by default
        @defaultBoxKind = "markdown"

    insertBox: (position) ->
        console.log("Insert box: #{position}")
        boxId = "box" + @boxes.length
        box = BoxLib.buildBox(@defaultBoxKind, boxId)
        #console.log("box.html = " + box.html())
        @boxMap[boxId] = box
        if @selectedBox == -1
                $("#boxed").append(box.html())
                box.installBox()
                @selectedBox = @boxes.length - 1    
                @boxes.push box
        else
            switch position
              when "before"
                 $(@boxes[@selectBox].id).insertBefore(box.html())
                 box.installBox()
                 @boxes.insertBefore(@selectedBox)
                 @selectBox(@selectedBox)
              when "after"
                 $(@boxes[@selectBox].id).insertAfter(box.html())
                 box.installBox()
                 @boxes.insertAfter(@selectedBox)
                 @selectBox(@selectedBox+1)

###
#
# Generic operations on boxes :
# - commit   (start processing...)
# - edit     (start editing...)
# - hide/show
# - edit metadata
# - enable/disable   (editable or not)
# - copy/cut/delete/clear
# - insert after/insert before
# - focus management
# - selection management
###
         
class BoxLib.Box
     constructor: (@kind, @id) ->

     html:  ->
              """
              <div id="#{@id}" class="boxlib #{@kind}-box">
                   <div id="#{@id}-control" class="boxlib #{@kind}-box-control"/>
                   <div id="#{@id}-header" class="boxlib #{@kind}-box-header"/>
                   <div id="#{@id}-content" class="boxlib #{@kind}-box-content"/>
                   <div id="#{@id}-footer" class="boxlib #{@kind}-box-footer"/>
              </div>
              """ # "

###
#
# Specific operations on Markdown boxes
# - hide code/show view on commit
# - live preview  (top/down  or left/right)
###
                        
class BoxLib.MarkdownBox extends BoxLib.Box
    constructor: (id) ->
        super("markdown",id)

    installBox: () ->
        $("##{@id}-content").append("<textarea id=\"#{@id}-markdown-edit\" class=\"boxlib #{@kind}-box-content\"/>")
        @codeMirror = CodeMirror.fromTextArea(document.getElementById("#{@id}-markdown-edit", {
                                                autofocus: true
                                                mode: "text/markdown"
                                              }));
        

###
#
# Specific operations on Section boxes
# - hide code/show view on commit
# - auto-toc   (update/show a computed table of contents)
#
####



###
#
# Specific operations on Live-coding boxes
# - evaluate code/show outputs and last return value on commit
# - show output index if evaluated
# - live-coding  (top/down or left/right)
#
# Supported live-coding languages:
# - javascript
# - coffeescript
###
