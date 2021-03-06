##
# The API's controller.
##
define(["Document","JavascriptBackend","MarkdownBackend","Presentor","EventEmitter"],((Documnent,JavascriptBackend,MarkdownBackend,Presentor,EventEmitter) ->

  #@service[Controler]
  #@class[Controler]
  class Controller extends EventEmitter

    #@constructor[init] -> [Controler]
    #@method[Controler] : Method creating control API.
    #@return[Controler] : The newly created controller.
    constructor: ->
      #@param[document][Documnent]
      @document = new Documnent("boxed")

      #@param[contentEditors][Hashtable<String><CodeMirrorEditor>]: Hashtable containing the list of editors of content.
      @contentEditors = {}

      #@param[userMetaEditors][Hashtable<String,CodeMirrorEditor>]: Hashtable containing the list of editors of the userMetadata.
      @userMetaEditors = {} 

      #@param[backendManager][Hashtable<String,Backend>]: Hashtable containing the list of the backends.
      @backendManager = {}

      #@param[presontor][EventEmitter]: The EventEmitter 
      this.addListener("putEditor",this.addContentEditor)

      @presentor = new Presentor(this)

      @backendManager["JAVASCRIPT"] = new JavascriptBackend()
      @backendManager["MARKDOWN"] = new MarkdownBackend()
    
      this.addListener("putEditor",this.addContentEditor)

    #@operator[appendBoxEnd]: [Controler] x String -> [Controler]
    #@method[appendBoxEnd]: Add a box at the end of the document.
    #@arg[type] : The type of the add box.
    appendBoxEnd: (type) ->
      this.updateBox( @document.getSelectBox() )
      box = @document.appendBoxEnd(type)
      if box is null then return null

      data = 
          order: "ADD_BOX"
          position:"END"
          result : @backendManager[box.getType()].chew(box)

      @presentor.emitEvent("update_view",[data])

    #@operator[appendBox]: [Controler] x String  x Boolean -> [Controler]
    #@method[appendBox]: Add a box at the end of the document.
    #@arg[type] : The type of the add box.
    #@arg[id] : The identifier of the box used to anchor the position of the new box.
    #@param[position][boolean]: A boolean indicating whether the box is to be added before (true) or after (false) the box whose ID was passed as a parameter.      
    appendBox: (type,id,position) ->
      this.updateBox( @document.getSelectBox() )
      box = @document.appendBoxPosition(type,id,position)
      insert = null
      if box is null then return null
      if position is true then insert = "BEFORE"
      else insert = "AFTER"
      data = 
        order: "ADD_BOX"
        position: insert
        anchor: id
        result: @backendManager[box.getType()].chew(box)

      @presentor.emitEvent("update_view",[data])

    #@operator[appendBoxSaved]: [Controler] x String x String x String x JSONObject x String -> [Controler]
    #@method[appendBoxSaved]: Private method to create a box, and add to the document.
    #@arg[id][String] : Name of the Box to load.
    #@arg[content][String] : The contents of the box.
    #@arg[mode][String] : The mode of the box.
    #@arg[userMetaData][JSONObject] : Meta-users of the box.
    #@arg[type][String] : The type of the box.
    #@return[Box] : The new box and added newly created.
    appendBoxSaved : (id,content,mode,userMetaData,type) ->
      box = @document.appendSavedBox(id,type)
      if box is null then return null
      box.setUserMetaData(userMetaData)
      box.setMode(mode) 
      box.setContent( content.replace(/\\+n/g,"\n").replace(/\\+t/g,"\t") )

      return box

    #@operation[selectBox]: [Controler] x String -> [Controler]
    #@method[selectBox]: Method to select a mailbox on the model.
    #@param[id][String]: 
    selectBox: (id) ->
      this.updateBox( @document.getSelectBox() )
      try
        @document.setSelectBox(id)

        data = 
          order: "SELECT_BOX",
          select: id

        @presentor.emitEvent("update_view",[data])
      catch e1
        console.log e1

    #@opeation[removeBox] : [Controler] x String -> [Controler]
    #@method[removeBox] : Public method to delete a document box.
    #@arg[id][String] : The id of the box to be delete.
    removeBox: (id) ->
      this.updateBox( @document.getSelectBox() )
      this.selectBox(id)
      try
        @document.removeBox(id)
        delete @contentEditors["#{id}"]

        if id of @userMetaEditors then delete @userMetaEditors["#{id}"]

        data = 
          order: "REMOVE_BOX"
          id : id

        @presentor.emitEvent("update_view",[data])
      catch e
        console.log e

    #@operation[setModeBox]: [Controler] x String x String -> [Controler]
    #@method[setModeBox]: Méthod for changing the mode of the box and save the metadata in a box.
    #@arg[id][String]: The id of the box to set the mode.
    #@arg[mode][String]: The future mode if the box.
    setModeBox: (id,mode) ->
      this.updateBox( @document.getSelectBox() )
      this.selectBox(id)

      try
        box = @document.getBox(id)
        data = null ;

        if "#{mode}" is "EDIT_USER_META" and box.getMode() is "EDIT_USER_META"
          try
            box.setUserMetaData( JSON.parse( @userMetaEditors["#{id}"].getValue() ) )
            data = this.getUserMetaDataCommitOrder(box) 
            data['result']['message'] = "Save Success!"
          catch e
            data = this.getUserMetaDataCommitOrder(box)
            data['result']['message'] = "Syntax Error!"
                    
        else if "#{mode}" isnt "EDIT_USER_META"
          box.setMode(mode)
          data = this.getStandardCommitOrder(box) 
        else 
          box.setMode(mode)
          data = this.getUserMetaDataCommitOrder(box)

        @presentor.emitEvent("update_view",[data])
      catch e
        console.log e

    #@operation[init] : [Controler] x String ->
    #@method[init] : Method for initializing the application, by implementing UserMetaData publisher of the document.
    #@arg[String]  : The identifier of the textarea that will serve as new editor for editing userMetaData oF Document.
    init: (id) ->
      data = 
        order : "INIT"
        result :
          id : id
          result : JSON.stringify( @document.getUserMetaData() )
          mime : "application/json"
      @presentor.emitEvent("update_view",[data])

    #@operation[setDocumentUserMetaData]: [Controler] x String -> [Controler]
    #@method[setDocumentUserMetaData]: Method for changing UserMetaData.
    #@arg[id][String] : The identifier of the textarea that will serve as new editor for editing userMetaData of Document.
    setDocumentUserMetaData : (id) ->
      data =
        order : "SET_BOX"
        result :
          id : id 
          mime : "application/json"
          mode : "EDIT_USER_META"

      try
        @document.setUserMetaData(JSON.parse(@userMetaEditors["#{id}"].getValue()))
        data['result']['result'] = @document.getUserMetaData() 
        data['result']['message'] = "Saving Success!"
      catch e                
        data['result']['result'] = @document.getUserMetaData()
        data['result']['message'] = "Syntax Error!"

      @presentor.emitEvent("update_view",[data])

    #@operator[saveDocument]: [Controler] -> [Controler]
    #@method[saveDocument] :Method to create a file representing the document in JSON format.
    #@arg[fileName]: The name of the new document.
    saveDocument: (fileName) ->
      data = 
        order : "DD_FILE"
        fileName : "#{fileName}.json"
        result : JSON.stringify( @document.exportJSON() )

      @presentor.emitEvent("update_view",[data])

    #@operator[operator][loadDocument]: [Controler] x String -> Controler
    #@method[loadDocument]: Method to load a doument from a file.
    #@arg[file]: The name of the file to load.
    loadDocument : (file) ->
      for id of @contentEditors
        this.removeBox(id)

      controler = this
      document = @document
      backendManager = @backendManager
      presentor = @presentor

      try
        reader = new FileReader()
        reader.onload = (event) ->
          result = event.target.result
          result = result.replace(/\\"/g,'"')
          result = result.replace(/^"/,"").replace(/"$/,"")

          saved = JSON.parse( result )

          document = new Documnent(saved['name'])
          document.setUserMetaData( saved['userMetaData'] )

          controler.loadBoxes(saved['boxes']) 
          controler.selectBox( saved['boxSelect'] )

        reader.readAsText(file)
      catch e
        console.log e            

    #@operator[operator][loadBoxes] : Private method to load a list of boxes recovered from a file.
    #@method[loadBox]: Private method to load a list of boxes recovered from a file.
    #@args[box][LinkedList<Box>] : The list of the box to be loaded.
    loadBoxes : (boxes) ->
      for box in boxes
        myBox = this.appendBoxSaved( box['id'],box['content'],box['mode'],box['userMetaData'],box['type'] )

        data = 
          order: "LOAD_BOX" 
          theBox: @backendManager[myBox.getType()].chew(myBox)

        if box['mode'] is "COMMIT" then data['theMeta'] = this.getStandardCommitOrder(myBox)
        else if box['mode'] isnt "EDIT_USER_META" then data['theMeta'] = this.getStandardCommitOrder(myBox)
        else data['theMeta'] = this.getUserMetaDataCommitOrder(myBox)

        @presentor.emitEvent("update_view",[data])

    #@operato[getStandardCommitOrder]: [Controler] x Box -> [JSONObject]
    #@method[getStandardCommitOrder]: Private method of providing a JSONobject containing the necessary information to be able ro deliver either Presentor a box mode commit ot editable mode.
    #@arg[box][Box]: The box of which is to obtain the display.
    #@return[JSONObject]: The necessary data to permit a propoer display of the box.
    getStandardCommitOrder: (box) ->
      data = 
        order : "SET_BOX"
        result : @backendManager[box.getType()].chew(box)

      return data

    #@method[getStandardCommitOrder]: Private method retrieving JSON result of the commit method lorque mode is EDIT_USER_META.
    #@arg[box][Box]: The box in which retrieve information.
    #@return[JSONObject] : JSON containing the necessary information to display.
    getUserMetaDataCommitOrder: (box) ->
      data = 
        order : "SET_BOX"
        result : 
          id : box.getId()
          result : JSON.stringify( box.getUserMetaData() )
          mime : "application/json"
          mode : box.getMode()

      return data

    #@operator[addEditor] : [Controler] x [CMEditor] x [String] -> [Controler]
    #@pre[addEditor(i,CM,w)] : require s not_own editors or userMetaEditors
    #@method[addEditor] : Add a box's CodeMirror editor to the param class editor.
    addContentEditor:(id,editor,wichEditor) ->
      if wichEditor is true
        if! ("#{id}" of @contentEditors ) 
          @contentEditors[id] = editor
          @contentEditors[id].markClean()
        else console.log "Error! The box #{id} already have its contentEditor!"
      else
        if! ("#{id}" of @userMetaEditors ) 
          @userMetaEditors["#{id}"] = editor
        else console.log "Error! The box #{id} already have its userMetaEditors!"

    ##operation[updateBox] : [Controler] x [Box] -> [Controler]
    #@method[updateBox] : Method that update the content of the box.
    #@arg[box][Box] : The box to update content.
    updateBox : (box) ->
      if box isnt null
        if @contentEditors[box.getId()].isClean() is false
          switch box.getMode() 
            when "COMMIT" then box.setContent( @contentEditors[box.getId()].getValue() )
            when "EDIT_CONTENT" then box.setContent( @contentEditors[box.getId()].getValue() )
          @contentEditors["#{box.getId()}"].markClean() 

  return Controller
))
