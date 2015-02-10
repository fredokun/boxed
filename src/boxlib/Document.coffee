##
#
# Class that is represent a Document.
#
##

class window.Document extends BoxAdministrator

        #Constructor
        constructor : (@name) ->
                @currentBox = null
                @userMetaData = {}
                @controlMetaData = {}
                super

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
                try current = this.getBox(idBox)                        
                catch e then throw error

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
