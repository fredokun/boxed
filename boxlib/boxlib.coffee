
###
#
# Boxlib #
#
# The library about Boxed' boxes.
#
###

class AbstractBox
    constructor: (@kind) ->
        @dependBoxes = []
        @childBoxes = []
        @metadata = {}
        @contentMime = ""
        @content = ""
   
    toHTML: () ->
        "<font color="red">Abstract box</font> (please report)"


class TextBox extends AbstractBox
    constructor: () ->
        super("text")
        @contentMime = "text"
        @content = ""

    toHTML: () ->
        "<p>#{@content}</p>"


class HTMLBox extends AbstractBox
    constructor: () ->
        super("html")
        @contentMime = "text/html"
        @content = ""

    toText: () ->
        @content

    toHTML: () ->
        @content


class MarkdownBox extends AbstractBox
    constructor: () ->
        super("markdown")
        @contentMime = "text/markdown"
        @content = ""
        
    toText: () ->
        @content

    toHTML: () ->
        Markdownizer.markdonize(@content)


class CodeBox extends AbstractBox
    constructor: (@lang) ->
        super("code")
        @resultBox = null


    evaluate: (ctx) ->
        throw "Abstract method"

    

