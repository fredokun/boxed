##
#
##

define([],(() ->

        ##service[LinkedBox]
        #@class[LinkedBox] :
        class LinkedBox

                ##constructor[init] : [Box] -> [LinkedBox]
                #@method[LinkedBox] : Method that create a new LinkedBox object.
                #@arg[box][Box] : The box to chain.
                constructor : (@box) ->
                        #@param[box] : The box chain.
                        #@param[next] : The next element of this link.
                        @next = null

                        #@param[previous] : The previous element of this link.
                        @previous = null

                ##operation[setNext] : [LinkedBox] x [LinkedBox] -> [LinkedBox]
                #@method[setNext] : Method setting the next element of the object.
                #@arg[next][LinkedList] : The future next element.
                setNext: (next) ->
                        @next = next

                ##operation[setPrevious] : [LinkedBox] x [LinkedBox] -> [LinkedBox]
                #@method[setPrevious] : Method setting the previous element of the object.
                #@arg[previous][LinkedList] : The future previous element.
                setPrevious: (previous) ->
                        @previous = previous

                ##opeation[deleteLink] : [LinkedBox] -> [LinkedBox]
                #@method[deleteLink] : Method tha delete the element from the list.
                deleteLink: ->
                        if @previous isnt null then @previous.setNext( @next )
                        if @next isnt null then @next.setPrevious( @previous )

                ##observator[getBox] : [LinkedBox] -> [Box]
                #@method[getBox] : Method that returns the box of the object.
                #@return[Box] : The value a the box content in the object.
                getBox : ->
                        return @box

                ##observator[getNext] : [LinkedBox] -> [LinkedBox]
                #@method[getNext] : Method that returns the next LinkedList of the object.
                #@return[LinkedBox] : The value a the box content in the object.
                getNext : ->
                        return @next

                ##observator[getPrevious] : [LinkedBox] -> [LinkedBox]
                #@method[getBox] : Method that returns the previous LinkedBox of the object.
                #@return[LinkedBox] : The value a the box content in the object.
                getPrevious : ->
                        return @previous

        return LinkedBox

))
