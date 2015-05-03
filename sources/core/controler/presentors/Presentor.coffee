##
# Class representing the presenter. The element linking the view and the controller.
##

define(["jquery","EventEmitter","cm/lib/codemirror","cm/mode/markdown/markdown","cm/mode/javascript/javascript"],(($,EventEmitter,CodeMirror) ->

    #@class[presntor]
    #@service[Presentor]
    #refine[Presentor]EventEmitter
    class Presentor extends EventEmitter

        #@constructor[init] -> [EventEmitter] -> [Presentor]
        #@method[Presentor]: Creating a method Presenter type of object.
        constructor: (@callback) ->
            #@param[callback]: The callback allows the presenter to point and send the new editor to create controller.
            super()
            this.addListener("update_view",this.updateView)

        #@operator[updateView]: [Presentor] x [JSONObject] -> [Presentor]
        #@method[updateView]: Method called by the callback, where the manufacturer wants to send an event to Presentor.
        updateView: (data) ->
            switch data["order"] 
                when "ADD_BOX"

                    if data['position'] is 'END' 
                        $('#document #boxes').append this.drawBox(data['result'])

                    else if data['position'] is 'AFTER'  
                        $("##{data['anchor']}").after this.drawBox(data['result'])
                    else if data['position'] is 'BEFORE' then $("##{data['anchor']}").before(this.drawBox(data['result']))
                    else return null

                    @callback.emitEvent("putEditor",[ data['result']['id'], this.drawEditor(data['result']['id'],data['result']['mime'],data['result']['result']), true ])

                    this.unSelectBox()
                    this.selectBox( "#{data['result']['id']}" )

                when "SELECT_BOX"
                    this.unSelectBox()
                    this.selectBox(data['select'])

                when "REMOVE_BOX"
                    $("##{data['id']}").remove() 

                when "SET_BOX"
                    if data['result']['mode'] is "EDIT_CONTENT" then this.editContent(data['result'])
                    else if data['result']['mode'] is "COMMIT" then this.editCommit(data['result'])
                    else if data['result']['mode'] is "EDIT_USER_META" 
                        if this.editUser(data['result']) is true 
                            @callback.emitEvent("putEditor",[ data['result']['id'], this.drawUserMetaEditor(data['result']['id'],data['result']['mime'],data['result']['result']), false ])
                            
                    else 
                            console.log "COMMAND '#{data['result']['mode']}' not manage!"
                            return null

                    this.unSelectBox()
                    this.selectBox( "#{data['result']['id']}" )

                when "INIT"
                    @callback.emitEvent("putEditor",[ data['result']['id'], this.drawUserMetaEditor(data['result']['id'],data['result']['mime'],data['result']['result']), false ])

                when "DD_FILE"
                    a = $ "<a id='test'>" 
                    $("#saveFileShade").append a

                    a.append "Download"

                    blob = new Blob([ JSON.stringify( data['result'] ) ], {type: "text/plain"})
                    url = window.URL.createObjectURL(blob) ;

                    a.attr "href", url;
                    a.attr "download", data['fileName']

                    window.URL.revokeObjectURL(url+".json");
                   

                else
                    console.log "This command '#{data['order']}' is not manage."

        #@operator[editUser]: [Presentor] x [JSONObject] -> [Presentor]
        #@method[edtUser] : Method creating and displaying an editor UserMetadata of the box.
        #@arg[result] : The JsonObject containing all the necessary information for displaying or creating the user metaData editor of the box.
        editUser: (result) ->
            $("#editorPanel_#{result['id']}").removeClass "contentVisible"
            $("#editorPanel_#{result['id']}").addClass "contentHidden"

            $("#resultPanel_#{result['id']}").removeClass "contentVisible"
            $("#resultPanel_#{result['id']}").addClass "contentHidden"

            editorJSON = $("#userMetaData_#{result['id']}")
            theReturn = false 

            if editorJSON.length is 0
                editorJSON = this.createEditorJSON(result['id'])
                $("#box_content_#{result['id']}").append editorJSON
                theReturn = true

            if! ("message" of result) is false 
                console.log result['message'] 
                console.log $("#message_compil_userMeta_#{result['id']}")
                $("#message_compil_userMeta_#{result['id']}").empty()
                $("#message_compil_userMeta_#{result['id']}").append result['message']
            else 
                $("#message_compil_userMeta_#{result['id']}").empty()

            editorJSON.removeClass "contentHidden"
            editorJSON.addClass "contentVisible"
            return theReturn

        #@operator[createEditorJSON]: [Presentor] x String -> JSONObject
        #@method[createEditorJSON]: Private method that returns the items to add to the DOM for adding a user Metadata editor.
        #@return[JSONObject] : The new element to add to the DOM.
        createEditorJSON: (id) ->
            editorJSON = $ "<section id='userMetaData_#{id}'>"
            commiteMessage = $ "<section id='message_compil_userMeta_#{id}'>"
            textarea = $ "<textarea id='userMeta_#{id}'>"

            editorJSON.append commiteMessage
            editorJSON.append textarea

            $("#box_content_#{id}").append editorJSON

            return editorJSON

        editContent: (result) ->
            $("#editorPanel_#{result['id']}").removeClass "contentHidden"
            $("#editorPanel_#{result['id']}").addClass "contentVisible"

            $("#resultPanel_#{result['id']}").removeClass "contentVisible"
            $("#resultPanel_#{result['id']}").addClass "contentHidden"

            if $("#userMetaData_#{result['id']}").length isnt 0
                $("#userMetaData_#{result['id']}").removeClass "contentVisible"
                $("#userMetaData_#{result['id']}").addClass "contentHidden"

                $("#message_compil_userMeta_#{result['id']}").empty()


        editCommit : (result) ->
            $("#editorPanel_#{result['id']}").removeClass "contentVisible"
            $("#editorPanel_#{result['id']}").addClass "contentHidden"

            $("#resultPanel_#{result['id']}").removeClass "contentHidden"
            $("#resultPanel_#{result['id']}").addClass "contentVisible"

            if $("#userMetaData_#{result['id']}").length isnt 0 
                $("#userMetaData_#{result['id']}").removeClass "contentVisible"
                $("#userMetaData_#{result['id']}").addClass "contentHidden"

                $("#message_compil_userMeta_#{result['id']}").empty()

            $("#resultPanel_#{result['id']}").empty() 

            if result['type'] is "CODE" then this.getCommitCode(result)
            else if result['type'] is "TEXT" then this.getCommitText(result)

        getCommitText : (result) ->
            $("#resultPanel_#{result['id']}").append result['result']

        getCommitCode: (result) ->
            codebox = $ "<section class='codeBox'>"
            textbox = $ "<section class='textBox'>"

            codebox.append result['content'] 
            textbox.append result['result']
            $("#resultPanel_#{result['id']}").append codebox
            $("#resultPanel_#{result['id']}").append textbox

        unSelectBox: () ->
            selectedMenu =  $(".visible")
            selectedContent =  $(".select")

            if selectedMenu.length is 0 then return null

            selectedMenu.removeClass 'visible'
            selectedMenu.addClass 'unvisible'
                        
            if selectedContent.length isnt 0 then selectedContent.removeClass 'select'

        selectBox: (id) ->
            if id is null then return null
            $("#box_menu_#{id}").removeClass 'unvisible'
            $("#box_menu_#{id}").addClass 'visible'

            $("#box_content_#{id}").addClass 'select'

        drawBox: (data) ->
            container = $ "<section class='box' id='#{data['id']}'>"
            menu = this.drawBoxMenu(data['id'])
            boxContainer = this.drawBoxContainer(data)

            container.append menu
            container.append boxContainer

            container.on "click", (event) ->
                Boxed.selectBox("#{data['id']}")
                event.stopPropagation()

            return container

        drawBoxMenu: (id) ->
            box = $ "<section class='boxMenu' id='box_menu_#{id}'>"
            listMenu = $ "<ul class='listerMenu'>"

            list1 = this.drawItemMenu(id,"Add box after","./../sources/img/arrow-with-circle-down.svg", null,"elemMenu")
            list1.append this.drawBoxSubMenu(id,false)

            list2 = this.drawItemMenu(id,"Add box before","./../sources/img/arrow-with-circle-up.svg", null,"elemMenu")
            list2.append this.drawBoxSubMenu(id,true)

            listMenu.append list1
            listMenu.append list2

            listMenu.append this.drawItemMenu(id,"Edit MetaData","./../sources/img/code.svg",(() -> 
                Boxed.setModeBox(id,"EDIT_USER_META")
            ),"elemMenu")
            listMenu.append this.drawItemMenu(id,"Edit Content Box","./../sources/img/pencil.svg", (()->
                Boxed.setModeBox(id,"EDIT_CONTENT")
            ),"elemMenu")
            listMenu.append this.drawItemMenu(id,"Commit Box","./../sources/img/flash.svg", (()->
                Boxed.setModeBox(id,"COMMIT")
            ),"elemMenu")
            listMenu.append this.drawItemMenu(id,"Remove box","./../sources/img/cross.svg", (()->
                Boxed.removeBox(id)
            ),"elemMenu")
            listMenu.append this.drawItemMenu(id,"#{id}","./../sources/img/shareable.svg",null,"elemMenuId")

            box.append listMenu

            return box

        drawBoxSubMenu: (id,position) ->
            subMenu = $ "<section class='subMenu' >"
            listMenu = $ "<ul class='listerMenu'>"

            listMenu.append listMenu.append this.drawItemMenu(id,"Markdown Box","./../sources/img/box.svg", (()->
                Boxed.appendBox("MARKDOWN",id,position)
            ),"subElemMenu")

            listMenu.append this.drawItemMenu(id,"Javascript Box","./../sources/img/box.svg", (()->
                Boxed.appendBox("JAVASCRIPT",id,position)
            ),"subElemMenu")

            subMenu.append listMenu
            return subMenu

        #
        #
        drawItemMenu: (id,name,img,fun,style) ->
            element = $ "<li class='#{style}'>"
            link = $ "<a href='#'>"
            img = "<img class='menuIcon' src='#{img}' alt='x'>"
            link.on "click", (event) ->
                if fun isnt null then fun()
                event.stopPropagation()

            link.append img
            link.append name
            element.append link

            return element

        drawBoxContainer: (data) ->
            container = $ "<section class='boxContent' id='box_content_#{data['id']}'>"

            resultPanel = $ "<section id='resultPanel_#{data['id']}' class='contentHidden'>"
            resultPanel.attr "type","text/html"
            editorPanel = $ "<section id='editorPanel_#{data['id']}' class='contentVisible'>"
            textArea = $ "<textarea id='textarea_#{data['id']}'>"

            editorPanel.append textArea
            container.append editorPanel
            container.append resultPanel

            return container

        drawEditor: (id,mime,value) ->
            editor = CodeMirror.fromTextArea(document.getElementById("textarea_#{id}"), {
                value: "#{value}",
                mode: mime,
            })
            editor.setSize("100%","auto")
            return editor 

        drawUserMetaEditor: (id,mime,value) ->
            editor = CodeMirror.fromTextArea(document.getElementById("userMeta_#{id}"), {
                value : "#{value}",
                mode : mime
            })
            editor.setSize("100%","auto")
            return editor 


    return Presentor

))
