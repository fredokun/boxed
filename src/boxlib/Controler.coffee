class Controler
        
        #Create all the backends and a Document by default.
        constructor: ->
                #The new Document by default.
                @doc = new Document("myDoc")

                #The collection of the Backends
                @backends = []

                for key, index in BoxType.BoxType
                        switch key

                
