(($) ->

) jQuery

$ ->
        
        class Controler

                #Create all the backends and a Document by default.
                constructor: ->
                        #The new Document by default.
                        @doc = new Document("myDoc")
                        @ids = 0

                        #The collection of the Backends
                        @backends = []

                        for key, index in BoxType.BoxType
                                switch key 
                                        when MARKDOWN then @backends.push new JavascriptBackend()
                                        when JAVASCRIPT then @backends.push new MarkdownBackend()

                        addBoxEnd:  ->
                                @dox.addbox(new Box(@ids))
                                @ids++

window.frame = new Controler();
