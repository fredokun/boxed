##
#
##

define(["LinkedBox","MarkdownBox","JavascriptBox"],((LinkedBox,MarkdownBox,JavascriptBox) ->
        
        ##service[Document]
        #@class[Document] :
        class Document

                ##contructor[init] : String -> [Document]
                #@method[Document] : Methot that inits a new Document.
                #@param[name][String] : The name od the create Document.
                constructor : (@name) ->
                        #@param[name][String] : The Document's name.
                        #@param[boxes][LinkedBox] : List of boxes contents in the Document.
                        @boxes = null

                        #@param[select][Box] : The box selected.
                        @select = null

                        #@param[boxMap][HashMap<String,LinkedBox>] : A map of al the boxes contents in the Document.
                        @boxMap = {}

                        #@para[ids][int] : A value that serves to create new ids for box.
                        @ids = 0

                ##operation[appendBox] : [Document] x String -> [Box]
                ##pre[appendBox(t)] : requires t = "MARKDOWN"
                #@method[appendBox] : Add a box to the Document and return this box.
                #@arg[type][String] : The type of the Box to add.
                #@return[Box] : The new Box created.
                appendBox: (type) ->
                        box = null
                        id = this.genId()

                        if id is null then return box
        
                        switch type
                                when "MARKDOWN" then box = new MarkdownBox( id ) 
                                when "JAVASCRIPT" then box = new JavascriptBox( id )                                         
                                else 
                                        console.log "[:(] Error! The type '#{type}' is not managed... [):]"
                                        return box

                        link = new LinkedBox(box) 

                        if @boxes is null then @boxes = link
        
                        link.setNext(@boxes)
                        link.setPrevious(@boxes.getPrevious()) 

                        if @boxes.getPrevious() isnt null then @boxes.getPrevious().setNext(link) ;
                        @boxes.setPrevious(link)

                        @boxMap["#{box.getId()}"] = link

                        @select = box

                        return box 

                ##operation[appendBefore] : [Document] x String x String -> [Document]
                #@method[appendBefore] : Add a before the box, that the id is put in parmeter.
                #@arg[type][String] : The box type.
                #@arg[id][String] : The box id of the box we add to put before.
                #@return[appendBefore]
                appendBefore: (type,id) ->
                        box = null ;
                        switch (type) 
                                when "MARKDOWN"  
                                        myId = this.genId()
                                        if id isnt null then box = new MarkdownBox(myId) 
                                        else return null
                                else 
                                        console.log "[:(] Error! The type '#{type}' is not managed... [):]"
                                        return box

                        if ! ("#{id}" of @boxMap) 
                                console.log "Error box #{id} not found"
                                return null

                        link = @boxMap["#{id}"]
                        n_link = new LinkedBox(box)

                        n_link.setNext( link ) 
                        n_link.setPrevious( link.getPrevious() )

                        if @boxes.getBox().getId() isnt id then link.getNext().setNext( n_link ) 
                        else 
                                link.getPrevious().setNext( n_link )
                                @boxes = n_link

                        link.setPrevious( n_link )

                        @select = box

                        if link.getBox().getId() is @boxes.getBox().getId() then @boxes = n_link 

                        @boxMap["#{box.getId()}"] = n_link
                        return box

                ##operation[appendAfter] : [Document] x String x String -> [Document]
                #@method[appendAfter] : Add a after the box, that the id is put in parmeter.
                #@arg[type][String] : The box type.
                #@arg[id][String] : The box id of the box we add to put after.
                #@return[Box] : The new box created.
                appendAfter: (type,id) ->
                        box = null ;
                        switch (type) 
                                when "MARKDOWN"  
                                        myId = this.genId()
                                        if id isnt null then box = new MarkdownBox(myId) 
                                        else return null
                                else 
                                        console.log "[:(] Error! The type '#{type}' is not managed... [):]"
                                        return box

                        if ! ("#{id}" of @boxMap) 
                                console.log "Error box #{id} not found"
                                return null

                        link = @boxMap["#{id}"]
                        n_link = new LinkedBox(box)

                        n_link.setNext( link.getNext() )
                        n_link.setPrevious( link )

                        link.getNext().setPrevious( n_link )
                        link.setNext( n_link )

                        @select = box

                        @boxMap["#{box.getId()}"] = n_link
                        return box

                ##operation[deleteBox] : [Document] x String -> [Document]
                ##require[deleteBox(i)] : require boxMap own id
                #@method[deleteBox] : Method that delete a box from the Document.
                #@arg[id][String] : The id of the box to delete.
                deleteBox : (id) ->
                        if ! ( "#{id}" of @boxMap ) then return false

                        if "#{id}" is @boxes.getBox().getId() 
                                if "#{id}" is @boxMap["#{id}"].getNext().getBox().getId() then @boxes = null
                                else @boxes = @boxMap["#{id}"].getNext()

                        @boxMap["#{id}"].deleteLink() ;
                        delete @boxMap["#{id}"]
                        
                        console.log @boxes

                        return true                        
                
                ##operation[selectBox] : [Document] x String -> [Document]
                ##require[selectBox(i)] : require id own boxes
                #@method[selectBox] : Method that select a box on the view/model.
                #@arg[id][String] : The id of the box selected.
                selectBox: (id) ->
                        if ! ("#{id}" of @boxMap ) then return null
                        @select = @boxMap["#{id}"].getBox()
                        return @boxMap["#{id}"].getBox()

                ##operation[removeBox] : [Document] x [String] -> [Document]
                #@method[removeBox] : Method that retrive a box from the Document.
                #@arg[id][String] : A string that 

                ##obervator[getSelect] : [Document] -> [Box]
                #@method[getSelect] : Method that return a new box select.
                getSelect: ->
                        @select

                ##observator[getBox] : [Document] x String -> [Box]
                ##pre[getBox(i)] : require i own boxMap
                #@method[getBox] : Method that search an return a box.
                #@return[Box] : A box
                getBox: (id) ->
                        if ! ("#{id}" of @boxMap) then  return null
                        return @boxMap["#{id}"].getBox()

                ##operation[genId] : [Document] -> [String]
                ##pre[genId()] : requires genId() not_own boxMap
                #@method[genId] : Private method that generates a new String id for a create Box.
                #@return[String] : The new Id created.
                genId : ->
                        result = "#{@name}_#{@ids}"
                        if ! ( "#{result}" of @boxMap ) then @ids++
                        else 
                                console.log "[:(] Error! A box with this id '#{result}' already exists! [):]"
                                return null

                        return result

        return Document
))
