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

        $("#userMetaData_document").removeClass "contentHidden"
        $("#saveFileShade").removeClass "contentVisible"
        $("#loadFileShade").removeClass "contentVisible"

        $("#userMetaData_document").addClass "contentVisible"
        $("#saveFileShade").addClass "contentHidden"
        $("#loadFileShade").addClass "contentHidden"    

        event.stopPropagation() 

    $("#shadeCover").on "click", (event) ->
        $("#shadeCover").removeClass "contentVisible"
        $("#shadeCover").addClass "contentHidden"

        $("#userMetaData_document").removeClass "contentVisible"
        $("#saveFileShade").removeClass "contentVisible"
        $("#loadFileShade").removeClass "contentVisible"

        $("#userMetaData_document").addClass "contentHidden"
        $("#saveFileShade").removeClass "contentHidden"
        $("#loadFileShade").removeClass "contentHidden"

        event.stopPropagation() 

    $(".shadeElement").on "click", (event) ->
        event.stopPropagation()

    $("#setDocumentUserMetaData").on "click", (event) ->
        $("#message_compil_userMeta_document").empty()
        Boxed.setDocumentUserMetaData("document")     

        event.stopPropagation()

    $("#saveDocument").on "click", (event) ->
        $("#shadeCover").removeClass "contentHidden"
        $("#shadeCover").addClass "contentVisible"

        $("#userMetaData_document").removeClass "contentVisible"
        $("#saveFileShade").removeClass "contentHidden"
        $("#loadFileShade").removeClass "contentVisible"

        $("#userMetaData_document").addClass "contentHidden"
        $("#saveFileShade").addClass "contentVisisble"
        $("#loadFileShade").addClass "contentHidden"

        event.stopPropagation()

    $("#save").on "click", (event) ->
        Boxed.saveDocument( $("#fileNameSave").val() )
        event.stopPropagation()

    $("#shadeCover").addClass "contentHidden"