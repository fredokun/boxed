(($) ->
) jQuery

class window.Controler

        #Create all the backends and a Document by default.
        constructor: ->
                #The new Document by default.
                @doc = new Document("myDoc")
                #The collection of the Backends
                @backends = []        
                for key, index of BoxType
                        switch key
                                when 'MARKDOWN'
                                        @backends[index] = new MarkdownBackend()  
                                when 'JAVASCRIPT'
                                        @backends[index] = new JavascriptBackend()
                                else console.log('error no type')


        #Add a new (javascript) box to the Documment. In the same time, it's 
        addBoxEnd:  (type) ->
                #Add the box to the document and the backends.
                @doc.addBox(type)

        selectBox: (idBox) ->
                @doc.setCurrentBox(box.getId())

        insertBoxBefore : (idBox) ->
                @doc.addBoxBefore(idBox);

        runBoxCallBack: (info) ->
                console.log "box add 1 "+this
                switch info['action']
                        when "DRAW_BOX_END"

                                cl = 'javascript' if info['boxType'] is 'JAVASCRIPT'
                                console.log "box add "+@doc

                                $('#contains').append("<section class='box' id='#{info['id']}' onclick='frame.selectBox(#{info['id']})' >
                                <nav class='boxTopMenu'>
                                <ul class='mainMenu'>
                                <li>
                                <img src='../images/menu.gif' class='imgToMenu' />
                                <ul class='subMenu'>
                                <li><a href='#' /> Change mode</li>
                                <li><a href='#' /> Change Type</li>
                                <li><a href='#' onclick='frame.insertBoxBefore()' /> Insert Before</li>
                                <li><a href='#' /> Insert After</li>
                                <li><a href='#' /> Clean Box</li>
                                </ul>
                                </li>
                                <li>#{info['id']}</li></ul>
                                </nav>
                                <section id='code' >
                                </section
                                </section>")

                                myCodeMiror = CodeMirror( $("\##{info['id']} #code").get(0), { mode : cl  } )                    
     
                        when "SELECT_BOX"
                                console.log @doc
                                prev = @doc.getCurrentBox()
                                now = $('\##{info[id]}')
                                if prev not null
                                        id = prev.getId()
                                        $('\##{id}').removeClass('boxSelect')
                                        $('\##{id}}').addClass('box')

                                $('\##{now}').removeClass('box')
                                $('\##{now}').removeClass('boxSelect')
                        else
                                console.log "No Action..."

window.frame = new Controler() ;
