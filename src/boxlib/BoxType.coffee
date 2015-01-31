##
#Enumerative 'Class' (not really a class) of the type of boxes
#For the moment, only MARKDOWN and JAVASCRIPT are present.
##

#Declaration of the box types. If you need to add a new box type you juste have to add it there.
BoxType = 
        MARKDOWN :  0 ,    
        JAVASCRIPT : 1

#Function of verifacation of the type.
isTyped = (typeName) ->
        type if key is typeName for key, type in BoxType
        null

