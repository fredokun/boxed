##
#
# Class that is represent a Document.
# Part of the model.
#
##

define(['Box','EventEmitter'],((Box,EventEmitter) ->

        class Document

                # @method Constructor of a document. The administrator of the Box.
                # @arg name : The name of the Document.
                # @arg callback : The callback of the Document.
                constructor : (@name, @callback) ->

                        # @ids : The next id of the future created Box.
                        @ids  = 0 

                        # @oldIds : When a box is delete its id saved in this variable, and put to an another id when we create a new one.
                        @oldIds = []

                        # @boxes : The list of the boxes present in the document.
                        @boxes = []

                        @userMetaData = {}
                        @controlMetaData = {}

                        #The currently selected box.
                        @current = null 

                #
                #
                getCurrent : ->
                        @current 

                # OPERATIONS OF THE DOCUMENT

                # @method addBox : Method adding a new box to Document.
                # @arg type : The type of the add box.
                addbox : (type) ->
        
                        # Creating the box.
                        box = new Box(this.getId(),type)

                        # Add the box to the Document.
                        @boxes.push(box)

                        # The Document send announce to the callback hads a box add.
                        info = 
                                command : "ADD_BOX_END"
                                box : box

                        # Active the callback.
                        @callback.emitEvent('modelUpdapted',[info])

                # @method addBox : Method adding a box after box whose id was set parameter.
                # @arg type : The type of box to be created.
                # @arg id : The identifier of the box in which the new box will be put forward.
                addBoxAfter : (type, id) ->
                        # Recovery of the new box to add.
                        box = new Box(this.getId(),type)

                        # Retrieving the index of the box .
                        index = this.getIndex(id)

                        # Tests of the index recover.
                        if index is -1 then return index

                        # Added in the collection box.
                        @boxes.splice(index+1,0,box)

                        info =
                                command : "ADD_BOX_AFTER"
                                box : box
                                id : id

                        # Calling the update callback model.
                        @callback.emitEvent('modelUpdapted',[info])                        

                addBoxBefore : (type, id) ->
                # @method addBox : Method adding a box before box whose id was set parameter.
                # @arg type : The type of box to be created.
                # @arg id : The identifier of the box in which the new box will be put forward.
                # Recovery of the new box to add.
                        box = new Box(this.getId(),type)

                        # Retrieving the index of the box .
                        index = this.getIndex(id)

                        # Tests of the index recover.
                        if index is -1 then return index

                        # Added in the collection box.
                        @boxes.splice(index,0,box)

                        info =
                                command : "ADD_BOX_BEFORE"
                                box : box
                                id : id

                        # Calling the update callback model.
                        @callback.emitEvent('modelUpdapted',[info])

                # @method selectBox : Method to select a box on the model .
                # @arg id  : The identifier of the selected box.
                selectBox: (id) ->
                        if @current is null then old = null
                        else old = this.getBox( @current.getId() );

                        @current = this.getBox(id)
                  
                        info = 
                                command : "SELECT_BOX"
                                old : old
                                current : @current

                        # Calling the update callback model.
                        @callback.emitEvent('modelUpdapted',[info])

                # @method getbox : Method that retrieves a box referenced by the parameter.
                # @arg id : The identifier of the box to find.
                # @return : The box corresponding to the identifier or null.
                getBox : (id) ->
                        for box in @boxes
                                if box.getId() is id then return box
                        return null

                # Method retrieving the index of the box whose ID was set parameter.
                # @arg id : The identifier of the box to find.
                # @return : L'index de la boîte correspondant à l'identifiant ou -1.
                getIndex : (id) ->
                        cpt = 0 
                        for box in @boxes
                                if id is box.getId() then return cpt
                                else cpt++
                        return -1
                

                # GETTER OF THE DOCUMENT (observer)
                # Method that return a id avaible for a new Box
                getId : ->
                        # Creation of an varaible for the result.
                        result = -1
                        # If The class variable @oldIds had numbers, we 'shift' one in the result.
                        if @oldIds.length > 0 then result = @oldIds.shift() 
                        else 
                                # Else we give a new id.
                                result = @ids
                                @ids++

                        # Return the result.
                        result

        return Document
))
