##
#
##

define(["jquery","EventEmitter","cm/lib/codemirror","cm/mode/markdown/markdown","cm/mode/javascript/javascript"],(($,EventEmitter,CodeMirror) ->

        ##service[Presentor]
        #@class[Presnetor]
        class Presentor extends EventEmitter
                
                ##constructor[init] : callback  -> [Presentor]
                #@method[Presentor] : Creates a new Presentor.
                #@arg[callback] : The callback that permits to the Presentor to send event to the Controler.
                constructor : (@callback) ->
                        super() 
                        #@param[callback][EventEmitter]
                        this.addListener("in_scene",this.takeRole)
                
                ##operator[takeRole] : [Presentor] x JSONobject -> [Presentor]
                #@method[takeRole] : Takes a JSONobject request and treats it.
                #@arg[data][JSONobject] : Object that contains the informations to perform actions on the DOM.
                takeRole : (data) ->
                        switch data["order"]                                        
                                when "SLT_BOX"
                                        this.selectBox(data)
                                when "CMT_BOX"
                                        this.changeContent(data)
                                when "ADD_BEF","ADD_END","ADD_AFT"
                                        box = this.drawBox(data["box"])
                                        select = $(".boxSelect")
                                        if select isnt null 
                                                select.removeClass 'boxSelect'
                                                select.attr 'class', 'box'

                                        if data["order"] is "ADD_BEF" then $("##{data['bef_box'].getId()}").before(box) 
                                        else if data["order"] is "ADD_AFT" then $("##{data['aft_box'].getId()}").after(box) 
                                        else if data["order"] is "ADD_END" then $(".page .container").append box

                                when "DEL_BOX"
                                        $("##{data['id']}").remove()
                                
                                else console.log "[:(] Error! Order not managed... [):]"

                ##operation[changeContent] : [Presentor] x [JSONobject] -> [Presentor]
                #@method[changeContent] : Change the content of the box according to the box mode.
                #@arg[data][JSONObject] : The informations that would be useful for perform the changement.
                changeContent: (data) ->
                        switch data["box"].getMode()
                                when "COMMIT"
                                        #$("##{data.box.getId()}_commit").show()
                                        #$("##{data.box.getId()}_standard").hide()                                        

                                        $("##{data.box.getId()}_editor").hide()                                        
                                        $("##{data.box.getId()}_result").show()             

                                        $("##{data.box.getId()}_result").empty()

                                        console.log data["box"].isCodable()

                                        if data["box"].isCodable() is true
                                                value = $ "<section>"
                                                result = $ "<section>"

                                                #myContentView = data['box'].getContent()
                                                #console.log "CONTENT COPIED #{myContentView}"
                                                #console.log "source #{data['box'].getContent()}"
                                                #myContentView.replace("\n","<br/>",g) ;
                                                #myContentView.replace("\t","      ",g) ;

                                                value.append data['box'].getContent() #myContentView
                                                result.append data['result'] 

                                                console.log data['box'].getContent()
                                                console.log data['result'] 

                                                $("##{data.box.getId()}_result").append value
                                                $("##{data.box.getId()}_result").append result
                                        else 
                                                $("##{data.box.getId()}_result").append data["result"]

                                when "EDITABLE"
                                        $("##{data.box.getId()}_result").empty()

                                        $("##{data.box.getId()}_editor").show()                                        
                                        $("##{data.box.getId()}_result").hide()

                                when "EDIT_USER_META"
                                        $("##{data.box.getId()}_result").empty()

                                        $("##{data.box.getId()}_editor").show()                                        
                                        $("##{data.box.getId()}_result").hide()
                                        
                ##opeation[selectBox] : [Presentor] x [JSONObject] -> [Presentor]
                #@method[selectBox] : Method that change the box css : select to not_select on inverse.
                #@arg[data][JSONobject] : The informations need for perfom the chagement.
                selectBox : (data) ->        
                        if data["old"] isnt null 
                                $("##{data['old'].getId()}").removeClass "boxSelect"
                                $("##{data['old'].getId()}").attr "class", "box"
                        $("##{data['box'].getId()}").removeClass "box"
                        $("##{data['box'].getId()}").attr "class", "boxSelect"                        

                ##opeation[drawBox] : [Presentor]x[Box] -> [DOM]
                #@method[drawBox] : Private method used for draned a box on the model.
                #@arg[tobox][Box] : The box to add to the model.
                #@return[DOM] : The Dom to add to the view.
                drawBox: (tobox) ->                        
                        box = $ "<section>"
                        box.attr "class", "boxSelect"
                        box.attr "id", "#{tobox.getId()}"

                        menu = this.menu(tobox.getId())
                        content = this.editContent(tobox)

                        box.append menu
                        box.append content

                        box.on "click", (event) ->
                                Boxed.selectBox(tobox.getId())
                                event.stopPropagation()                                
                        return box

                menu: (id) ->
                        menu = $ "<section>"

                        menu.attr "class","boxMenu"                        
                        
                        standard = this.standardMenu(id)
                        commit = this.commitMenu(id)

                        menu.append standard
                        #menu.append commit

                        #commit.hide()

                        return menu

                commitMenu : (id) ->
                        commit = $ "<section id='#{id}_commit'>"
                        ul = $ "<ul class='menu'>"
                        li1 = $ "<li class='elem' id='commitBox'>"
                        li2 = $ "<li class='elem' id='removeBox'>"
                        img1 = $ "<img src='./../sources/images/commit.png' class='imgBoxMenu'>"
                        img2 = $ "<img src='./../sources/images/delBox.png' class='imgBoxMenu'>"

                        a1 = $ "<a href='#'>"
                        a2 = $ "<a href='#'>"

                        a1.append img1
                        a2.append img2

                        li1.append a1
                        li2.append a2

                        ul.append li1
                        ul.append li2

                        a1.on "click", (event) ->
                                Boxed.commitBox(id)
                                event.stopPropagation()

                        a2.on "click", (event) ->
                                Boxed.removeBox(id)
                                event.stopPropagation()

                        commit.append ul
                        return commit

                standardMenu: (id) ->
                        std = $ "<section id='#{id}_standard'>"
                        
                        ul = $ "<ul class='menu'>"

                        li1 = $ "<li class='elem' id='commitBox'>"
                        li2 = $ "<li class='elem' id='removeBox'>"
                        li3 = $ "<li class='elem_left' id='boxId'>"
                        li4 = $ "<li class='elem' id='addBefore'>"
                        li5 = $ "<li class='elem' id='addAfter'>"
                        li6 = $ "<li class='elem' id='setUserMetaData'>"
                        li7 = $ "<li class='elem' id='editable'>"

                        a1 = $ "<a href='#'>"
                        a2 = $ "<a href='#'>"
                        a4 = $ "<a href='#'>"
                        a5 = $ "<a href='#'>"
                        a6 = $ "<a href='#'>"
                        a7 = $ "<a href='#'>"

                        #img1 = $ "<img src='./../sources/images/commit.png' class='imgBoxMenu'>"
                        #img2 = $ "<img src='./../sources/images/delBox.png' class='imgBoxMenu'>"
                        #img4 = $ "<img src='./../sources/images/addBox.png' class='imgBoxMenu'>"
                        #img5 = $ "<img src='./../sources/images/addBox.png' class='imgBoxMenu'>"
                        #img6 = $ "<img src='./../sources/images/setMetaUser.png' class='imgBoxMenu'>"

                        a1.on "click", (event) ->
                                Boxed.commitBox(id,"COMMIT")
                                event.stopPropagation()

                        a2.on "click", (event) ->
                                Boxed.removeBox(id)
                                event.stopPropagation()

                        a4.on "click", (event) ->
                                Boxed.addBefore("MARKDOWN",id)
                                event.stopPropagation()

                        a5.on "click", (event) ->
                                Boxed.addAfter("MARKDOWN",id)
                                event.stopPropagation()

                        a6.on "click", (event) ->
                                Boxed.commitBox(id,"EDIT_USER_META")
                                event.stopPropagation()

                        a7.on "click", (event) ->
                                Boxed.commitBox(id,"EDITABLE")
                                event.stopPropagation()

                        a1.append "+ Commit" #img1
                        a2.append "+ Delete" #img2
                        a4.append "+ Add Before" #img4
                        a5.append "+ Add After" #img5
                        a6.append "+ Edit User Meta Data" #img5
                        a7.append "+ Edit Box"

                        li1.append a1                                                
                        li4.append a4
                        li5.append a5
                        li2.append a2
                        li6.append a6
                        li7.append a7
                        li3.append id

                        ul.append li3
                        ul.append li1
                        ul.append li2
                        ul.append li4
                        ul.append li5
                        ul.append li6
                        ul.append li7

                        std.append ul

                        return std

                editContent : (box) ->
                        mime = null

                        switch box.getMode()
                                when "MARKDOWN" then mime = "markdown"
                                when "JAVASCRIPT" then mime = "javascript"

                        content = $ "<section>"
                        content.attr "class","content"
                        content.attr "id","content_#{box.getId()}"

                        codeLayer = $ "<section id='#{box.getId()}_editor'>"
                        resultLayer = $ "<section id='#{box.getId()}_result'>"

                        resultLayer.attr "type","#{mime}"

                        codeLayer.show()
                        resultLayer.hide()

                        area = $ "<textarea>"
                        codeLayer.append area

                        content.append codeLayer
                        content.append resultLayer
                        
                        editor = CodeMirror( (elt) -> 
                                area.replaceWith(elt)
                        , {
                                value: box.getContent() 
                                mode: mime
                                cursorBlinkRate:100
                        }) ;

                        @callback.emitEvent("the_backstage",[editor,box.getId()])
                        content

        return Presentor                
))
