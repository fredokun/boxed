(($) ->

) jQuery

$ ->
        
  $("#fileMenu").menu().hide()
  $("#editMenu").menu().hide()

  $("#fileMenuButton").button()
  $("#fileMenuButton").click(
     () -> $("#fileMenu").toggle())

  $("#editMenuButton").button()
  $("#editMenuButton").click(
     () -> $("#editMenu").toggle())

