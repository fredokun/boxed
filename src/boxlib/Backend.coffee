##
#
#Abstract class that represent a Backend.
#It's more a way for force the future developpers to implements this class and the
#method of this class 'compile'.
#
##

class Backend extends BoxAdministrator

        #Method that compile a box (transform the inside to text to something else).
        compile : (box) ->
                #Here the method is not implemented. We just throw an error. Like That, if the method is not filled by the class that extends Backend an error is raised.
                trow Error "Unomplemented method."

        #Method that change the mode of the box.
        changeMode : (idBox,mode) ->
                box = getBox(idBox)

                switch
                        when mode is 0
                                this.compile(box);
        
