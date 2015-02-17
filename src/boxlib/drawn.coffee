(($) ->
) jQuery

$ ->

#Function that works only on hte model. It drawn a box and put this in the model
        window.drawnBox = (id) ->
                section = $ '<section>'

                section.addClass 'box'

                section.append drawMenu(id)
                section.append drawInsideBox(id)
                $('#page').append section                

        drawMenu = (id) ->
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
                a3.click -> deleteBox(id)
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

                nav

        drawInsideBox = (id) ->
                section = $ '<p>'
                section.addClass 'boxInside'
                section
