##
#
##

define(["Backend","commonmark"],((Backend,commonmark) ->

        ##service[Backend]
        #@method[Backend] :
        class MarkdownBackend extends Backend

                ##constructor[Backend] : -> [Backend]
                #@method[Backend] : Creates a new backend.
                constructor: ->
                        super()
                        
                        #@param[parser][commonMarkParser] : Markdown parser.
                        @parser = new commonmark.Parser()

                        #@param[writer][commonMarkParser] : Traductor of the parsed tree.
                        @writer = new commonmark.HtmlRenderer()

                ##operator[chew] : [Backend] x [Box] -> JSONobjet
                #@method[chew] : Method, takes a Box and return a JSON Object of the Box compile.
                #@arg[box][Box] : The box to 'compile'.
                #@return[JSONobject] : An object with the compile box content and its mime.
                chew : (box) ->
                        return @writer.render( @parser.parse( box.getContent() ) )

        return MarkdownBackend
))
