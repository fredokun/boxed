(($) ->
) jQuery

class window.Controler

        #Create all the backends and a Document by default.
        constructor: ->
                #The new Document by default.
                @doc = new Document("myDoc")
                @ids = 0
                #The collection of the Backends
                @backends = []        
                for key, index of BoxType
                        switch key
                                when 'MARKDOWN'
                                        @backends[index] = new MarkdownBackend()  
                                when 'JAVASCRIPT'
                                        @backends[index] = new JavascriptBackend()
                                else console.log('error no type');

                @callback = $.Callbacks()
                @callback.add( this.runBoxCallBack ) 

        #Add a new (javascript) box to the Documment. In the same time, it's 
        addBoxEnd:  ->
                #Creation of the box.
                box = new Box(@ids,@callback)

                #Add the box to the document and the backends.
                @doc.addBox(box)
                bac = @backends[BoxType.JAVASCRIPT]
                bac.addBox(box)                

                @doc.setCurrentBox( box.getId() );        
                @ids++

        runBoxCallBack: (info) ->
                switch info['action']
                        when "DRAW_BOX_END"

                                cl = 'javascript' if info['boxType'] is 'JAVASCRIPT'

                                $('#contains').append("<section class='box' id='#{info['id']}'>
                                <nav class='boxTopMenu'>
                                <ul class='mainMenu'>
                                <li>
                                <img src='../images/menu.gif' class='imgToMenu' />
                                <ul class='subMenu'>
                                <li><a href='#' /> Change mode</li>
                                <li><a href='#' /> Change Type</li>
                                <li><a href='#' /> Insert Before</li>
                                <li><a href='#' /> Insert After</li>
                                <li><a href='#' /> Clean Box</li>
                                </ul>
                                </li></ul>
                                </nav>
                                <section id='code' >
                                </section
                                </section>")


                                myCodeMiror = CodeMirror( $("\##{info['id']} #code").get(0), { mode : cl  } ) 
                        
                        when "SELECT_BOX"
                                prev = @doc.getCurrentBox()
                                now = $('\##{info[id]}')
                                if prev not null
                                        id = prev.getId()
                                        $('\##{id}').removeClass('boxSelect')
                                        $('\##{id}}').addClass('box')

                                $('\##{now}').removeClass('box')
                                $('\##{now}').removeClass('boxSelect')                

window.frame = new Controler() ;
