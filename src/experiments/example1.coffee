
# first some adjunction to arrays

@Array::insertBefore = (index, items...) ->
        @splice.apply(@,[index, 0].concat(items))
        return @

@Array::insertAfter = (index, items...) ->
        @splice.apply(@,[index+1, 0].concat(items))
        return @

# then initialization of JQuery shortcut

(($) ->

) jQuery

# and the entry point

$ ->
  BoxLib = (exports ? window).BoxLib
                
  boxedObj = new BoxLib.BoxEd
                                                                       
  $("#fileMenu").menu({select: (event,ui) -> fileMenuSelect(boxedObj, ui.item[0].id)}).hide()
  $("#editMenu").menu({select: (event,ui) -> editMenuSelect(boxedObj, ui.item[0].id)}).hide()

  $("#fileMenuButton").button()
  $("#fileMenuButton").click(
     () -> toggleMenu("#fileMenu"))

  $("#editMenuButton").button()
  $("#editMenuButton").click(
     () -> toggleMenu("#editMenu"))

  menuIds = ["#fileMenu", "#editMenu"]

  toggleMenu = (menuId) -> 
          # close other menus
          for otherMenuId in menuIds
                  if otherMenuId != menuId and $(otherMenuId).is(":visible")
                          $(otherMenuId).hide()

          # toggle menu
          $(menuId).toggle()

  closeMenus = () ->
          for menuId in menuIds
                $(menuId).hide()
        

  fileMenuSelect = (boxedObj, item) ->
          switch item
                  when "fileMenuNew"
                          console.log "FileMenu: new  selected"

          # close menus at the end
          closeMenus()

 
  editMenuSelect = (boxedObj, item) ->
          switch item
                  when "editMenuInsertBefore"
                          boxedObj.insertBox("before")
                  when "editMenuInsertAfter"
                          boxedObj.insertBox("after")

          # close menus at the end
          closeMenus()





