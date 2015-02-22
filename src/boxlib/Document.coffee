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

                        # @indexes : An Hashtable that can find a box in @boxes without looping in.
                        @indexes = []

                        @userMetaData = {}
                        @controlMetaData = {}

                        #The currently selected box.
                        @currentBox = null 

                # OPERATIONS OF THE DOCUMENT

                # @method addBox : Method adding a new box to Document.
                # @arg type : The type of the add box.
                addbox : (type) ->
        
                        # Creating the box.
                        box = new Box(this.getId(),type)

                        # Add the box to the Document.
                        @boxes.push(box)

                        # Updating indexes box.
                        size = @boxes.length
                        @indexes[ "#{box.getId()}" ] =  size-1 ;

                        # The Document send announce to the callback hads a box add.
                        info = 
                                command : "ADD_BOX_END"
                                box : box

                        # Active the callback.
                        console.log('Emit event')
                        @callback.emitEvent('modelUpdapted',[info])

                # Method that retrieves a box referenced by the parameter.
                getBox : (id) ->
                
                        # If the 'id' do not exists in the indexes.
                        if !("#{id}" in @indexes) then throw Error

                        @boxes[ @indexes["#{id}"] ]
                
                

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
