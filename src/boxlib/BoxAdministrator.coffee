##
#
#Abstract class that's represent a class that administrate a List of box.
#
##

class window.BoxAdministrator
        #Constructor
        constructor : ->
                @boxes = []          #Array that contains the boxes.
                @indexes = []        #Hash that contains the index of box in the collection array.

        #Add a box in the collection of boxes.
        addBox : (box) ->
                #We check if the object already exist in the collection.
                if !(box.getId() in @indexes) 
                        @box.push(box)
                        @indexes["#{box.getId()}"] = @box.length-1
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
                throw error  
