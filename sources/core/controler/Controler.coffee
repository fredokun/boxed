##
#
##

define(["jquery","Document","MarkdownBackend","JavascriptBackend","Presentor","EventEmitter"],(($,Document,MarkdownBackend,JavascriptBackend,Presentor,EventEmitter) ->

        ##service[Controler]
        #@class[Controler]
        class Controler extends EventEmitter

                ##contructor[init] : -> [Controler]
                #@class[Controler] : API's controler. Controms and generate actions.
                constructor : ->
                        super()

                        #@param[document][Document] : Document objet, the model of the API
                        @document = new Document("newDoc")
                        
                        #@param[backendManager][HahsMap<String,Backend>] : Backends hashtble.
                        @backendManager = {}

                        #@param[presentor][Presentor] : API's presentor. It will perform action on the DOM.
                        @presentor = new Presentor(this)

                        #@param[editor][HashMap<String,CMEditor>] : List of each Boxes' CodeMirror editor  object.
                        @editors = {}

                        @backendManager["MARKDOWN"] = new MarkdownBackend(@presentor) 
                        @backendManager["JAVASCRIPT"] = new JavascriptBackend(@presentor) 

                        this.addListener("the_backstage",this.addEditor)

                ##operation[appendBox] : [Controler] x String -> [Controler]
                #@method[appendBox] : Method that add a box of type 'type' to the document.
                #@arg[type][String] : The type of the box.
                appendBox : (type) ->
                        box = @document.appendBox(type)
                        data =
                                order:"ADD_END"
                                box : box
                        @presentor.emitEvent("in_scene",[data])

                ##operation[selectBox] : [Controler] x String -> [Controler]
                #@method[selectBox] : Method that select a box on the view.
                #@arg[id][String] : A String indicating the id of the box selected.
                selectBox : (id) ->
                        old = @document.getSelect()
                        if old isnt null then this.updateBox( old ) ;

                        box = @document.selectBox(id) 
                        if box is null then return null 

                        data = 
                                order:"SLT_BOX"
                                old:old
                                box:box

                        @presentor.emitEvent("in_scene",[data])

                ##operation[commitBox] : [Controler] x String -> [Controler]
                #@method[commitBox] : Change the content of the box with its content compile.
                #@arg[id][String] : The id of the box to compile.
                commitBox: (id,mode) ->
                        box = @document.getBox(id)
                        if box is null then return null

                        this.updateBox box

                        switch mode
                                when "COMMIT" then box.setMode(mode)
                                when "EDITABLE"
                                        @editors["#{box.getId()}"].setOption("mode", () ->
                                                switch box.getType()
                                                        when "JAVASCRIPT" then return "javascript"
                                                        when "MARKDOWN" then return "markdown"
                                                        else console.log "Error! The type is not managed"
                                                return null
                                        )
                                        @editors["#{box.getId()}"].setValue(box.getContent())
                                        box.setMode(mode)
                                when "EDIT_USER_META"
                                        box.setMode(mode) ;
                                        @editors["#{box.getId()}"].setValue( JSON.stringify( box.getUserMetaData() ) )
                                        @editors["#{box.getId()}"].setOption("mode","json")
                                else return null

                        data =
                                order:"CMT_BOX"
                                box : box
                                result : @backendManager[box.getType()].chew(box)
                        @presentor.emitEvent("in_scene",[data])

                ##operation[addBefore] : [Controler] x String x String -> addBox
                #@method[addBefore] : Method that adds a box before an id put in argument.
                #@arg[type][String] : The type of the box.
                #@arg[id][String] : The box which we had to put the new box before.
                addBefore : (type,id) ->
                        box = @document.getBox(id)
                        toAppend = @document.appendBefore(type,id)
                        data = 
                                order : "ADD_BEF"
                                box : toAppend
                                bef_box : box
                        @presentor.emitEvent("in_scene",[data])

                ##operation[addAfter] : [Controler] x String x String -> addBox
                #@method[addAfter] : Method that adds a box before an id put in argument.
                #@arg[type][String] : The type of the box.
                #@arg[id][String] : The box which we had to put the new box before.
                addAfter : (type,id) ->
                        box = @document.getBox(id)
                        toAppend = @document.appendAfter(type,id)
                        data = 
                                order : "ADD_AFT"
                                box : toAppend
                                aft_box : box
                        @presentor.emitEvent("in_scene",[data])

                ##operation[deleteBox] : [Controler] x String -> [Controler] 
                ##require[deleteBox(i)] : require document.deleteBox = true
                #@method[deleteBox] : Method that remove a box.
                #@arg[id][String] : The id of the Box.
                removeBox : (id) ->
                        if @document.deleteBox(id) is false then return null 
                        delete @editors["#{id}"]
                        data =
                                order : "DEL_BOX"
                                id : id
                        @presentor.emitEvent("in_scene",[data])
        
                ##operation[addEditor] : [Controler] x [CMEditor] x [String] -> [Controler]
                ##pre[addEditor(CM,s)] : require s not_own editors
                #@method[addEditor] : Add a box's CodeMirror editor to the param class editor.
                addEditor: (editor,id) ->
                        if! ("#{id}" of @editors ) 
                                @editors["#{id}"] = editor
                                editor.markClean()
                        else console.log "[:(] Error! The box #{id} already have its editor! [):]"

                ##operation[updateBox] : [Controler] x [Box] -> [Controler]
                #@method[updateBox] : Method that update the content of the box.
                #@arg[box][Box] : The box to update content.
                updateBox : (box) ->
                        if @editors["#{box.getId()}"].isClean() == false
                                switch box.getMode() 
                                        when "EDIT_USER_META" then box.setUserMetaData( JSON.parse( @editors["#{box.getId()}"].getValue() ) )
                                        when "EDITABLE" then box.setContent( @editors["#{box.getId()}"].getValue() )
                                @editors["#{box.getId()}"].markClean() 

        return Controler
))
