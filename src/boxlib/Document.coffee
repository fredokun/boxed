##
#
# Class that is represent a Document.
#
##

class window.Document 

        #Constructor
        constructor : (@name) ->
                @currentBox = null
                @userMetaData = {}
                @controlMetaData = {}
                @boxes = []          #Array that contains the boxes.
                @indexes = []        #Hash that contains the index of box in the collection array.

        #Add a box in the collection of boxes.
        addBox : (box) ->
                #We check if the object already exist in the collection.
                if !(box.getId() in @indexes) 
                        @boxes.push(box)
                        @indexes["#{box.getId()}"] = @boxes.length-1
                else throw error

        #Remove a Box from a collection.
        removebox: (boxId) ->
                if boxId in @indexes
                        @boxes.splice(@indexes["#{boxId}"],1)   
                        delete @boxes["#{boxId}"]
                else throw error

        #Get a box from the collection.
        getBox : (boxId) ->
                if boxId in @indexes then @boxes["#{@indexes[boxId]}"]
                else throw error  

        #Get the attribute name
        getName: ->
                @name

        #Method that get the attribute class 'currentBox'.
        getCurrentBox : ->
                @currentBox

        #Mthos that set the name of the Document
        setDocument : (newName)->
                @name = newName

        #Set select box (set the attribute 'currentBox').
        setCurrentBox : (idBox) ->
                buffer = this.getBox(idBox)
                buffer.getSelected()
                @currentBox = buffer

        #Add a box before the select box.
        addBoxBefore : (boxSrc,newBox) ->
                if @boxSrc in @indexes 
                        index = @indexes["#{boxSrc}"]
                        @boxes.splice(index,0,newBox)

                        @indexes["#{newBox.getId()}"] = index

                        for i in [index+1..@boxes.length-1]
                                @indexes["#{@boxes[i].getId()}"]++

        #addBoxAfter the box selected.
        addBoxAfter : (boxSrc,newBox) ->
                if @boxSrc in @indexes 
                        index = @indexes["#{boxSrc}"]
                        @boxes.splice(index+1,0,newBox)

                        @indexes["#{newBox.getId()}"] = index

                        for i in [index+1 .. @boxes.length-1]
                                @indexes["#{@boxes[i].getId()}"]++
