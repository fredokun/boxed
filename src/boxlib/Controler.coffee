##
#
# Class Controler. It's receving the event from the view  and performe different actions, on the Model and the View.
#
##
define(['jquery'], (($) ->

class Controler

        ##
        # ALL THE OPERATIONS HERE ARE THE OPERATIONS PERFORM BY THE CONTROLER ON THE MODEL.
        # IT'S THE BOX/DOCUMENT/BACKEND THAT SIGNALS THE CONTROLER THAT IT CAN UPDATE THE MODEL
        # THANKFULLY TO THE CALLBACKS.
        ##


        #Constructor of the class controler. It inits a model, backends, and the callbacks necessary for the BoXed Project.
        constructor : ->
                #The model of the document.
                @doc = null
                #The list of all the backends.
                @backends = []
                @callbacks = null

        #Method that adding a box to the model after the box id put in parameter.
        #id : The id of the box that serves of reference for the adding.
        addBoxAfter: (id) ->
                @doc.addBoxAfter(id)

        #Method that adding a box to the model before the box id put in parameter.
        #id : The id of the box that serve of reference for adding the box.
        addAfter: (id) ->
                @doc addBoxAfter(id)

        #Method that delete the box with the if put in attribute.
        removeBox: (id) ->
                @doc removeBox

        ##
        # THE FUNCTIONS HERE ARE THE FUCNTIONS THAT WILL BE ADD TO THE CALLBACK.
        # THEY WILL BE CALL BY THE OTHER ELEMET OF THE MODEL.
        #

        drawBox : (id) ->
                # Creation of the container of the box.
                section = $ '<section>'
                # Creation of the subsction that will contains the of the box.
                text = $ '<section>'
                # Creation of the section that will be trade for create a CodeMirrorBox.
                inText = $ '<section>'

                # Adding the css that will make the appearation animation.
                section.addClass 'boxCreating'

                # Adding the trading section in the subction of the container.
                text.append inText

                # Creation of the top menu of the box.
                i1 = $ '<i>'
                i2 = $ '<i>'
                i3 = $ '<i>'
                i4 = $ '<i>'
                i5 = $ '<i>'
        
                i1.attr 'id', 'shortcut'
                i2.attr 'id', 'shortcut'
                i3.attr 'id', 'shortcut'
                i4.attr 'id', 'shortcut'
                i5.attr 'id', 'shortcut'

                i1.append '(shortcut)'
                i2.append '(shortcut)'
                i3.append '(shortcut)'
                i4.append '(shortcut)'
                i5.append '(shortcut)'

                a1 = $ '<a>'
                a2 = $ '<a>'
                a3 = $ '<a>'
                a4 = $ '<a>'
                a5 = $ '<a>'
                
                a1.attr 'href','#'
                a1.append 'Add Box Before'
                a1.click -> AddBoxBefore(id)
                a1.append i1

                a2.attr 'href','#'
                a2.append 'Add Box After'
                a2.click -> AddBoxAfter(id)
                a2.append i2

                a3.attr 'href','#'
                a3.append 'Delete Box'
                a3.click -> withdrawBox(id)
                a3.append i3

                a4.attr 'href','#'
                a4.append 'Change Type Box'
                a4.click -> deleteBox(ChangeType(id))
                a4.append i4

                a5.attr 'href','#'
                a5.append 'Change Mode Box'
                a5.click -> deleteBox(ChangeMode(id))
                a5.append i5

                li21 = $ '<li>'
                li22 = $ '<li>'
                li23 = $ '<li>'
                li24 = $ '<li>'
                li25 = $ '<li>'

                li21.append a1
                li22.append a2
                li23.append a3
                li24.append a4
                li25.append a5

                ul2 = $ '<ul>'

                ul2.append li21
                ul2.append li22
                ul2.append li23
                ul2.append li24
                ul2.append li25
                ul2.addClass 'boxSubMenu'

                li1 = $ '<li>' 
                li2 = $ '<li>' 
                li3 = $ '<li>' 
            
                li1.addClass 'listBoxMenuLeft'
                li2.addClass 'listBoxMenu'

                im = $ '<img>'
                im.attr 'src','../images/menu.gif'

                li2.append im

                li1.append "##{id}"
                li2.append ul2

                ul = $ '<ul>'

                ul.append li1
                ul.append li2

                nav = $ '<nav>'

                nav.append ul
                nav.addClass 'boxMenu'
                
                # Adding the navigation top bar to the Box.
                section.append nav
                # Adding the text section to the Box.
                section.append text
                #Put the id of the box to the Box
                section.attr 'id', id

                # Changing the css Box when the animation is over.
                section.on("animationend webkitAnimationEnd Oanimationend msAnimationEnd", (() -> 
                        $(this).removeClass("boxCreating") 
                        $(this).addClass("box")
                )
                )

                # Replace the subsection by a codemiror editor.
                codeMiror = CodeMirror( ((elt) ->
                        inText.replaceWith(elt)), { type : "markdown" } )

                # Putting the event of selection of the box.
                section.click -> drawSelect(id)

                # Adding the box to the View.
                $('#page').append section 
                

))
