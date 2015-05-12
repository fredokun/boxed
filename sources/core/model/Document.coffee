##
# The main element of the model, the Document. The container of all the boxes.
##
define(["JavascriptBox","MarkdownBox","DoublyChainedList"],((JavascriptBox,MarkdownBox,DoublyChainedList)->

    #@service[Document]
    #@class[Document]
    class Document

        #@constructor[init]: String -> [Document]
        #@method[Document]: Method for constructing a document.
        #@arg[name][String]: The name of the document is created.
        #@return[Document]: The newly created document.
        constructor : (@name) ->
            #@param[name][String] : The document name.
            #@param[boxesOrder][DoublyChainedList]: Boxes list.
            @boxesOrder = null 

            #@param[boxesMap][HashMap<String,Box>]: A hash table containing all the boxes of the document traceable by their identifiers.
            @boxesMap = {}

            #@param[boxSelect][Box]: The box selected by the user on the document.
            @boxSelect = null

            #@param[idGenerator][int]: 
            @idGenerator = 0 

            #@param[userMetaData][JSONObject]: 
            @userMetaData = {}
        
        #@observator[getSelectBox]: [Document] -> Box
        #@method: Method that returns the value of the class attribute 'boxSelect'.
        #@return[Box]: The value of the selected box.
        getSelectBox : ->
            @boxSelect

        #@operator[appendBoxEnd]: [Document] -> [Box]
        #@method[appendBox]: Method adding a box at the end of the document.
        #@param[type][String]: The type of the add box.
        #@param[Box]: The newly added box.
        appendBoxEnd: (type) ->
            try 
                box = null 
                switch type
                    when "JAVASCRIPT" then box = new JavascriptBox( this.genId() )
                    when "MARKDOWN" then box = new MarkdownBox( this.genId() )
                    else 
                        throw new Error("Unknown type box: '@{type}'")

                link = new DoublyChainedList(box)
                if @boxesOrder is null then @boxesOrder = link

                link.setNext(@boxesOrder)
                link.setPrevious(@boxesOrder.getPrevious())

                if @boxesOrder.getPrevious() isnt null then @boxesOrder.getPrevious().setNext(link) ;
                @boxesOrder.setPrevious(link)

                @boxesMap["#{box.getId()}"] = link
                @boxSelect = box

                return box

            catch e1
                console.log e1
                return null

        #@operator[appendSavedBox]: [Document] x String x String -> [Box]
        #@method[appendSavedBox]: Method loading a box at the end of the view.
        #@arg[id][String]: The identifier of the box to add.
        #@arg[type][String]: The type of the add box.
        #@arg[Box]: The newly added box.
        appendSavedBox : (id,type) ->
            myBox = null
            try  
                switch type
                    when "JAVASCRIPT" then myBox = new JavascriptBox(id )
                    when "MARKDOWN" then myBox = new MarkdownBox( id )
                    else
                        console.log "Box type Unknow '#{type}'"
                        return null

                link = new DoublyChainedList(myBox)
                if @boxesOrder is null then @boxesOrder = link

                link.setNext(@boxesOrder)
                link.setPrevious(@boxesOrder.getPrevious())

                if @boxesOrder.getPrevious() isnt null then @boxesOrder.getPrevious().setNext(link) ;
                @boxesOrder.setPrevious(link)

                @boxesMap["#{myBox.getId()}"] = link
                @boxSelect = myBox

                return myBox

            catch e1
                console.log e1
                return null


        #@operator[appendBoxEnd]: [Document] x String x Boolean -> [Box]
        #@pre appendBox(D,t,b) boxesMap own id
        #@method[appendBox]: Method adding another box after box whose identifier has been set as a parameter..
        #@param[type][String]: The type of the add box.
        #@param[id][String]: The identifier of the box used to anchor the position of the new box.
        #@param[position][boolean]: A boolean indicating whether the box is to be added before (true) or after (false) the box whose ID was passed as a parameter.
        #@param[Box]: The newly added box.
        appendBoxPosition: (type,id,position) ->
            try 
                box = null 
                switch type
                    when "JAVASCRIPT" then box = new JavascriptBox( this.genId() )
                    when "MARKDOWN" then box = new MarkdownBox( this.genId() )
                    else 
                        throw new Error("Unknown type box: '#{type}'.")

                if! ( id of @boxesMap) then throw new Error("Unknown box identifier : '#{id}'.")

                anchor = @boxesMap["#{id}"]
                link = new DoublyChainedList(box)

                if position is true
                    
                    link.setNext(anchor) 
                    link.setPrevious( anchor.getPrevious() )

                    anchor.getPrevious().setNext(link)
                    anchor.setPrevious(link)

                    if id is @boxesOrder.getElement().getId() then @boxesOrder = link

                else

                    link.setPrevious(anchor)
                    link.setNext(anchor.getNext())

                    anchor.getNext().setPrevious(link)
                    anchor.setNext(link)

                @select = box
                @boxesMap["#{box.getId()}"] = link
                return box

            catch e
                console.log e
                return null

        #@operator[removeBox]: [Document] x String -> [Document]
        #@method[removeBox]: Method of removing a paper box.
        #@arg[id][String]: The identifier of the box to remove.
        removeBox: (id) ->
            if! (id of @boxesMap) then throw new Error("Unknown box identifier : '#{id}'.")
            
            if id is @boxesOrder.getElement().getId() 
                if @boxesOrder.getNext().getElement().getId() is id then @boxesOrder = null
                else @boxesOrder = @boxesOrder.getNext()

            @boxesMap["#{id}"].removeLink()
            delete @boxesMap["#{id}"]

            if @boxSelect.getId() is id then @boxSelect = null

        #@observator[setSelectBox]: [Document] x id -> [Document]
        #@method[setSelectBox]: Method modifying the selected box on the document.
        setSelectBox: (id) ->
            if id is null then @boxSelect = null
            else 
                if! (id of @boxesMap) then throw new  Error("Unknown box identifier : '#{id}'.")
                else @boxSelect = @boxesMap["#{id}"].getElement()

        #@operator[setUserMetaData]: [Document] x String -> [Document]
        #@method[setuserMetaData]: Method for changing the userMetaData class attribute.
        setUserMetaData: (userMetaData) ->
            @userMetaData = userMetaData

        #@observator[getBox]: [Document] x String -> [Box]
        #@pre getBox(D,i) @boxMap own i
        #@method[getBox]: Returns an existing box in the model.
        #@arg[id][String]: The identifier of the box.
        #@return[Box]: The box for the ID parameter.
        getBox: (id) ->
            if! (id of @boxesMap) then throw new Error("The box of id '#{id}' does not exist.")
            return @boxesMap["#{id}"].getElement() 

        #@operator[setName] : [Document] x String -> [Document]
        #@method[setName] : Method changing the name of the document.
        #@arg[String] : The new document name.
        setName: (name) ->
            @name = name

        #@observator[getUserMetaData]: [Document] -> [JSONObject]
        #@method[getUserMetaData]: Accessor class parameter to 'userMetaData'.
        #@return[JSONObject]: The value of the class parameter 'userMetaData'.
        getUserMetaData : ->
            return @userMetaData

        #@operator[exportJSON]: [Document] -> [JSONObject]
        #@method[exportJSON]: Method that returns the value of the document in JSON format.
        #@return[JSONObject]: The document in JSON format.
        exportJSON: ->
            doc = 
                name : @name
                userMetaData : @userMetaData

            if @boxesOrder is null then doc['boxes'] = null
            else doc['boxes'] = @boxesOrder.exportJSON()

            if @boxSelect is null then doc['boxSelect'] = null
            else doc['boxSelect'] = @boxSelect.getId() 

            return doc

        #@operator[genId]: [Document] -> int
        #@pre require genId() not_own boxeMap.
        #@method[gentId]: Method generates a unique identifier for a box.
        #@return[int]: The identifier for the new box.
        genId: ->
            while "#{@name}_#{@idGenerator}" of @boxesMap
                @idGenerator++
            
            return "#{@name}_#{@idGenerator}"

    return Document
))
