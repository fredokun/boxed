##
# Class representing the presenter. The element linking the view and the controller.
##

define(["jquery","EventEmitter","cm/lib/codemirror","cm/mode/markdown/markdown","cm/mode/javascript/javascript"],(($,EventEmitter,CodeMirror) ->

  #@class[Presentor]
  #@service[Presentor]
  #refine[Presentor]: EventEmitter
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

          
          @callback.emitEvent("putEditor",[ data['result']['id'], this.drawEditor(data['result']['id'],data['result']['mime'],data['result']['content']), true ])

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
          a = $ "<a id='FileLink'>" 
          $("#saveFileShade").append a

          a.append "Download"

          blob = new Blob([ JSON.stringify( data['result'] ) ], {type: "text/plain"})
          url = window.URL.createObjectURL(blob) ;

          a.attr "href", url
          a.attr "download", data['fileName']

          window.URL.revokeObjectURL(url+".json")

        when "LOAD_BOX"
          $('#document #boxes').append this.drawBox(data['theBox'])
          @callback.emitEvent("putEditor",[data['theBox']['id'], this.drawEditor(data['theBox']['id'],data['theBox']['mime'],data['theBox']['content']), true ])

          if data['theMeta']['result']['mode'] is "EDIT_CONTENT" then this.editContent(data['theMeta']['result'])
          else if data['theMeta']['result']['mode'] is "COMMIT" then this.editCommit(data['theMeta']['result'])
          else if data['theMeta']['result']['mode'] is "EDIT_USER_META" 
            if this.editUser(data['theMeta']['result']) is true 
              @callback.emitEvent("putEditor",[ data['theMeta']['result']['id'], this.drawUserMetaEditor(data['theMeta']['result']['id'],data['theMeta']['result']['mime'],data['theMeta']['result']['result']), false ])

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

    #@operator[editContent]: [Presnetor] x [JSONObject] -> [JSONObject]
    #@method[editContent] : Method to set up the display of the editor of the box.
    #@arg[result][JSONObject] : The data to show the data of the box.
    editContent: (result) ->
      $("#editorPanel_#{result['id']}").removeClass "contentHidden"
      $("#editorPanel_#{result['id']}").addClass "contentVisible"

      $("#resultPanel_#{result['id']}").removeClass "contentVisible"
      $("#resultPanel_#{result['id']}").addClass "contentHidden"

      if $("#userMetaData_#{result['id']}").length isnt 0
        $("#userMetaData_#{result['id']}").removeClass "contentVisible"
        $("#userMetaData_#{result['id']}").addClass "contentHidden"

      $("#message_compil_userMeta_#{result['id']}").empty()

    #@operator[editCommit]: [Presentor] x [JSONObject] -> [Presentor]
    #@method[editCommit] : Private method for displaying commit the box.
    #@arg[result][JSONObject] : The data to show the data of the box.
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

    #@operator[getCommitText]: [Presentor] x [JSONObject] -> [Presentor]
    #@method[getCommitText]: Method for inserting the result of a box type TEXT in its view box.
    #@arg[result]: The data to show the data of the box.
    getCommitText : (result) ->
      $("#resultPanel_#{result['id']}").append result['result']

    #@operator[getCommitCode]: [Presentor] x [JSONObject] -> [Presentor]
    #@method[getCommitCode]: Method for inserting the result of a box type CODE in its view box.
    #@arg[result]: The data to show the data of the box.
    getCommitCode: (result) ->
      codebox = $ "<section class='codeBox'>"
      textbox = $ "<section class='textBox'>"

      codebox.append result['content'] 
      textbox.append result['result']
      $("#resultPanel_#{result['id']}").append codebox
      $("#resultPanel_#{result['id']}").append textbox
        
    #@operator[unSelectBox]: [Presentor] -> [Presentor]
    #@method[unSelectBox]: Method for unselecting a box on the view.
    unSelectBox: () ->
      selectedMenu =  $(".visible")
      selectedContent =  $(".select")

      if selectedMenu.length is 0 then return null

      selectedMenu.removeClass 'visible'
      selectedMenu.addClass 'unvisible'
                        
      if selectedContent.length isnt 0 then selectedContent.removeClass 'select'

    #@operator[unSelectBox]: [Presentor] -> [Presentor]
    #@method[unSelectBox]: Method for selecting a box on the view.
    #@arg[id][String] : The identifier of the box to select.
    selectBox: (id) ->
      if id is null then return null
      $("#box_menu_#{id}").removeClass 'unvisible'
      $("#box_menu_#{id}").addClass 'visible'

      $("#box_content_#{id}").addClass 'select'

    #@operator[drawBox]: [Prensentor] x [JSONObject] -> [Presentor]
    #@method[drawBox]: Method generates a box that can be added to the view.
    #@arg[data][JSONObject]: The necessary data to generate a box.
    #@return[JSONObject]: The new box generated to add to the view.
    drawBox: (data) ->
      container = $ "<section class='box' id='#{data['id']}'>"
      menu = this.drawBoxMenu(data['id'])
      boxContainer = this.drawBoxContainer(data)

      container.append menu
      container.append boxContainer

      container.dblclick( () ->
        Boxed.setModeBox(data['id'],"EDIT_CONTENT")
      )

      container.on "click", (event) ->
        Boxed.selectBox("#{data['id']}")
        event.stopPropagation()

      return container

    #@operator[drawBoxMenu]: [Presentor] x String -> [JSONObject]
    #@method[drawBoxMenu]: Method drawing the menu of the box in question.
    #@arg[id][String]: The identifier of the box.
    #@return[JSONObject]: The menu of the generated box.
    drawBoxMenu: (id) ->
      box = $ "<section class='boxMenu' id='box_menu_#{id}'>"
      listMenu = $ "<ul class='listerMenu'>"

      list1 = this.drawItemMenu(id,"Add after","./../sources/img/arrow-with-circle-down.svg", null,"elemMenu")
      list1.append this.drawBoxSubMenu(id,false)

      list2 = this.drawItemMenu(id,"Add before","./../sources/img/arrow-with-circle-up.svg", null,"elemMenu")
      list2.append this.drawBoxSubMenu(id,true)

      listMenu.append list1
      listMenu.append list2

      listMenu.append this.drawItemMenu(id,"MetaData","./../sources/img/code.svg",(() -> 
        Boxed.setModeBox(id,"EDIT_USER_META")
      ),"elemMenu")
      listMenu.append this.drawItemMenu(id,"Edit","./../sources/img/pencil.svg", (()->
        Boxed.setModeBox(id,"EDIT_CONTENT")
      ),"elemMenu")
      listMenu.append this.drawItemMenu(id,"Remove","./../sources/img/cross.svg", (()->
        Boxed.removeBox(id)
      ),"elemMenu")
      listMenu.append this.drawItemMenu(id,"Commit","./../sources/img/flash.svg", (()->
        Boxed.setModeBox(id,"COMMIT")
      ),"elemMenu")
      listMenu.append this.drawItemMenu(id,"#{id}","./../sources/img/shareable.svg",null,"elemMenuId")

      box.append listMenu

      return box

    #@operator[drawBoxMenu]: [Presentor] x String -> [JSONObject]
    #@method[drawBoxSubMenu]: Generating method as a menu item menu.
    #@arg[String]: The identifier of the box.
    #@return[JSONObject]: The menu of the generated box.
    drawBoxSubMenu: (id,position) ->
      subMenu = $ "<section class='subMenu' >"
      listMenu = $ "<ul class='listerMenu'>"

      listMenu.append listMenu.append this.drawItemMenu(id,"Markdown","./../sources/img/box.svg", (()->
        Boxed.appendBox("MARKDOWN",id,position)
      ),"subElemMenu")

      listMenu.append this.drawItemMenu(id,"Javascript","./../sources/img/box.svg", (()->
        Boxed.appendBox("JAVASCRIPT",id,position)
      ),"subElemMenu")

      subMenu.append listMenu
      return subMenu

    #@operator[drawItemMenu] x String x String x String x fun x String -> [JSONObject]
    #@method[drawItemMenu]: Method generating menu item.
    #@arg[id]: The identifier of the box.
    #@arg[name]: The label of the menu element.
    #@arg[fun]: The function to execute the model when clicking on the link.
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

    #@operator[drawBoxContainer]: [Presentor] x [JSONObject] -> [Presentor]
    #@method[drawBoxContainer]: Method that draws the contents of a box at its inception.
    #@arg[data][JSONObject]: Data for displaying the contents of the box.
    #@return[JSONObject]: The contents of the box.
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

    #@operator[drawEditor]: [Presentor] x String x String x String -> [CodeMirrorEditor]
    #@operator[drawEditor]: Method generates an editor for the newly created box.
    #@arg[id][String]: The identifier of the box.
    #@arg[mime][String]: The mime editor to create.
    #@arg[value][String]: The content of the editor if you want to initialize.
    #@return[JSONObject]: The text editor to create the new box.
    drawEditor: (id,mime,value) ->
      editor = CodeMirror.fromTextArea(document.getElementById("textarea_#{id}"), {
        mode: mime
      })
      editor.setSize("100%","auto")
      editor.setValue(value)

      editor.setOption("extraKeys", {
        "Shift-Enter": () ->
          Boxed.setModeBox(id,"COMMIT")
      })

      return editor 

    #@operator[drawUserMetaEditor]: [Presentor] x String x String x String -> [CodeMirrorEditor]
    #@operator[drawUserMetaEditor]: Method for generating publisher meta data of a box.
    #@arg[String]: The identifier of the box.
    #@arg[mime][String]: The mime editor to create.
    #@arg[value][String]: The content of the editor if you want to initialize.
    #@return[JSONObject]: The text editor to create the new box.
    drawUserMetaEditor: (id,mime,value) ->
      editor = CodeMirror.fromTextArea(document.getElementById("userMeta_#{id}"), {
        mode : mime
      })
      editor.setSize("100%","auto")
      editor.setValue(value)
            
      return editor

  return Presentor
))
