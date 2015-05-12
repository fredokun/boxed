##
# Utility class used to store objects and preserve their orders.
##
define([],(() ->

    #@service[DoublyChainedList<T>]
    #@class[DoublyChainedList<T>]
    class DoublyChainedList

        #@constructor[DoublyChainedList][init] : -> [DoublyChainedList<T>]
        #@method[DoublyChainedList][DoublyChainedList] : Method creating a doubly linked list item.
        #@arg[key][T] : The key element of the list doubly chained.
        #@return[DoublyChainedList<T>]
        constructor : (@key) ->
            #@param[key][T] : The key element of the list doubly chained.
            #@param[next][DoublyChainedList<T>]:The next element of the list.
            @next = null 
            @previous = null 

         exportJSON: ->
            buffer = @next
            result = []

            result.push @key.exportJSON()

            while @key.getId() isnt buffer.getElement().getId() 
                console.log buffer.getElement().exportJSON()
                result.push buffer.getElement().exportJSON()
                buffer = buffer.getNext()

            return result

        #@observator[getNext] : [DoublyChainedList] -> [DoublyChainedList]
        #@method[getNext] : Method that returns the value of the class attribute 'next'.
        #@return[getNext] : The value of the class attribute 'next'.
        getNext : ->
            @next

        #@observatorgetPrevious] : [DoublyChainedList] -> [DoublyChainedList]
        #@methodgetPrevious] : Method that returns the value of the class attribute 'previous'.
        #@returngetPrevious] : The value of the class attribute 'previous'.
        getPrevious : ->
            @previous

        #@observator[getElement]:
        #@method[getElement]:
        #@return[<T>]:
        getElement: ->
            @key

        #@operator[removeLink]: [DoublyChainedList] -> [DoublyChainedList]
        #@method[removeLink]: Method to remove a link from the list of elements.
        removeLink: ->
            @previous.setNext(@next) 
            @next.setPrevious(@previous)

        #@operatorsetNext] : [DoublyChainedList] -> [DoublyChainedList]
        #@methodsetNext] : Method that set the value of the class attribute 'next'.
        #@arg[next][T] : The new value of the class attribute 'next'.
        setNext : (next) ->
            @next = next

        #@operatorsetPrevious] : [DoublyChainedList] -> [DoublyChainedList]
        #@methodsetPrevious] : Method that set the value of the class attribute 'previous'.
        #@arg[Previous][T] : The new value of the class attribute 'previous'.
        setPrevious : (previous) ->
            @previous = previous

        #@operator[toString] : [DoublyChainedList] -> [DoublyChainedList]
        #@methodto[String] : Method printing on the standard output value of the object.
        toString : ->
            console.log this

    return DoublyChainedList   
))