##
#Enumerative 'Class' (not really a class) of the type of boxes
#For the moment, only MARKDOWN and JAVASCRIPT are present.
##

#Declaration of the box types. If you need to add a new box type you juste have to add it there.
window.BoxType = 
        MARKDOWN :  0 
        JAVASCRIPT : 1

#Function that verify tha the type in argument exists.
window.isTyped = (typeName) ->
        index if key is typeName for key, index in BoxType
        -1