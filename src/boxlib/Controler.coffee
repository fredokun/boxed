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
                                        console.log('javscript')
                                else console.log('error no type');

        #Add a new (javascript) box to the Documment. In the same time, it's 
        addBoxEnd:  ->
                #Creation of the box.
                box = new Box(@ids)

                #Add the box to the document and the backends.
                @doc.addBox(box)
                bac = @backends[BoxType.JAVASCRIPT]
                console.log( @backends );
                bac.addBox(box)                

                @doc.setCurrentBox( box.getId() );

                console.log(this)

                $("#contains").append("<section class='box' id='#{box.getId()}'>
                <nav class='boxTopMenu'>
                <ul class='ulMenu'>
                <li class='itemTopMenu'>
                <a src='#' />
                <img src='../images/menu.gif' height='35px' height='35px' />
                </li>
                </ul>
                </nav>        
                </section>") ;
                
                @ids++

        
                

window.frame = new Controler() ;
