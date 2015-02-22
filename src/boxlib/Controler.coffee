##
#
# Class representing the controler API. It receives event the view that transfer model. This prevents Controller by an event sent by a callback.
#
##
define(['jquery','Document','EventEmitter','CodeMirror'], (($,Document,EventEmitter,CodeMirror) ->

        class Controler extends EventEmitter

                # @method constructor : Builds a controller . It initializes the model . Inheriting the class ' EventEmitter ' the model knows only the controller that the class ' EventEmitter ' .
                constructor : ->

                        # Adding the receiving action for the callback.
                        this.addListener('modelUpdapted',this.callMe)

                        # Initialization of the document.
                        @doc = new Document("NewDocument",this)
        
                        # The list of all the backends.
                        @backends = []

                # @method addBox : Method adding a box at the end of the list of the box model.
                # @arg type : The type of box to be created.
                addBox: (type) ->
                        @doc.addbox(type,@callback)

                # @method addBox : Method adding a box after box whose id was set parameter.
                addBoxAfter : (type, id) ->
                        @doc.addBoxAfter(type,id)

                # @method callMe : The model callback function to advise that changes are needed on the model.
                # @arg info : A Json object to the callback indicating what are the action to perform.
                callMe : (info) ->

                        # We test the command to see which perform operation.
                        switch info.command
                
                                # Command name indicating you should add a box at end of document.
                                when "ADD_BOX_END"

                                        # Getting Box for instantiate a box model with the same 'attributes' (mode/type/...)
                                        box = info.box

                                        # The new box is drawn.
                                        drawnedBox = this.drawBox(box.getId())

                                        # Setting the type un the display of the Box.
                                        this.setModelContentBox( drawnedBox, box )

                                        # Add the box to the model.
                                        $("#page").append drawnedBox

                                when "ADD_BOX_AFTER"

                                        # The new box is drawn.
                                        boxed = this.drawBox(info.box.getId())
                                        # Installation of content
                                        this.setModelContentBox(boxed,info.box)

                                        console.log( $("#"+info.id) )
                                        
                                        # Inserting the box before the box set parameter in the infrmation .
                                        boxed.insertAfter( "#"+info.id )

                setModelContentBox : ( boxed, box) ->   
              
                        # Getting the control meta data.
                        data = box.getControlMetaData()

                        # Testing the display of the box
                        switch data.display

                                # If it's editable.
                                when "EDITABLE"
                
                                        # Content of the box is an editor.
                                        text = boxed.find("#content_"+box.getId())
        
                                        # Emptying the old contains of the box.
                                        text.empty()
                
                                        # Create a new Box that will serve of editor.
                                        buffer = $ '<textarea>'

                                        # Adding the buffer to the model.
                                        text.append buffer

                                        # Replacing the buffer of the editor
                                        CodeMirror( ((elt) ->
                                                text.replaceWith(elt)
                                        ), { mode : data.mime, value : data.values } )                                        
        
                # @method drawBox : Method that can draw a box with its id, the type, and display
                # @arg id : The id of the Box.
                drawBox : (id) ->
                
                        # Creation of the container of the box.
                        section = $ '<section>'
                        
                        # Creation of the subsction that will contains the of the box.
                        text = $ '<section>'
                        text.attr('id', "content_"+id)
        
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
                        #a1.click -> AddBoxBefore()
                        a1.append i1
        
                        a2.attr 'href','#'
                        a2.append 'Add Box After'
                        a2.click -> BoXed.addBoxAfter("markdown",id)
                        a2.append i2

                        a3.attr 'href','#'
                        a3.append 'Delete Box'
                        #a3.click -> withdrawBox(id)
                        a3.append i3
        
                        a4.attr 'href','#'
                        a4.append 'Change Type Box'
                        #a4.click -> deleteBox(ChangeType(id))
                        a4.append i4

                        a5.attr 'href','#'
                        a5.append 'Change Mode Box'
                        #a5.click -> deleteBox(ChangeMode(id))
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
                        ))

                        # Putting the event of selection of the box.
                        section.click -> BoXed.selectBox(id)

                        section

        return Controler

))
