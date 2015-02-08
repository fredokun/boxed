##
#Enumerative 'Class' (not realy a class) of the mode of boxes.
#For the moment four mode are available VIEW, EDIT_CONTROL,EDIT_META,EDIT_META_CONTROL.
##

#Declaration of the box modes. If you want to create a new mode, just add one there.
BoxMode = 
        VIEW : 0 
        EDIT_CONTROL : 1 
        EDIT_META : 2 
        EDIT_META_CONTROL : 3
        EDIT_CONTENT : 4

#Function that verify the type in arguments exists.
isModed = (modeName) ->
        index if mode is modeName for mode, index in BoxMode
        -1

module.exports = BoxMode
module.exports = isModed
