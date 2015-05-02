(($) ->
) jQuery

$ ->
    $("#addBoxEndJavascript").on "click", (event) ->
        Boxed.appendBoxEnd("JAVASCRIPT")
        event.stopPropagation()

    $("#addBoxEndMarkdown").on "click", (event) ->
        Boxed.appendBoxEnd("MARKDOWN") 
        event.stopPropagation()

    $("#boxes").on "click", (event) ->
        Boxed.selectBox(null) 
        event.stopPropagation()

    $("body").on "click", (event) ->
        Boxed.selectBox(null) 
        event.stopPropagation()

    $("#setUserMetaDataDocument").on "click", (event) ->
        $("#shadeCover").removeClass "contentHidden"
        $("#shadeCover").addClass "contentVisible"

        if $("#userMetaData_document .CodeMirror").length is 0
                Boxed.init("document")

        event.stopPropagation() 

    $("#shadeCover").on "click", (event) ->
        $("#shadeCover").removeClass "contentVisible"
        $("#shadeCover").addClass "contentHidden"
        event.stopPropagation() ;

    $("#shadeCover").addClass "contentHidden"

    $("#userMetaData_document").on "click", (event) ->
        event.stopPropagation()

    $("#setDocumentUserMetaData").on "click", (event) ->
        Boxed.setDocumentUserMetaData("document") 
        


