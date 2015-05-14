##
# Class defining the architecture of a backend.
##
define(["Backend","commonmark"],((Backend,commonmark)->
  #@service[MarkdownBackend]
  #@class[MarkdownBackend]
  class MarkdownBackend extends Backend

    #@contructor[init]: -> [MarkdownBackend]
    #@MarkdownBackend: Method building a backend object type.
    #@return: The newly built backend.
    constructor: ->
      super()
      #@param[parser][commonMarkParser] : Markdown parser.
      @parser = new commonmark.Parser()

      #@param[writer][commonMarkParser] : Traductor of the parsed tree.
      @writer = new commonmark.HtmlRenderer()

    #@operator[chew]: [MarkdownBackend] x [Box] -> [JSONObject]
    #@method[chew]: Method taking a box and returning the contents of the box 'compiled' in Markdown.
    #@arg[box][Box]: The box to compile.
    #@return[JSONObject]: The contents of the compiled box.
    chew: (box) ->
      result =
        id : box.getId()
        type : "TEXT"
        content : box.getContent()
        result : @writer.render( @parser.parse( box.getContent() ) )
        mime : "markdown"
        mode : box.getMode()
      return result

  return MarkdownBackend
))