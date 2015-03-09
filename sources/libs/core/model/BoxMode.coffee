BOX_MODE = 
	VIEW : "view"
	EDIT_CONTENT : "edit_content"
	EDIT_CONTROL_META_DATA : "edit_control_meta_data"
	EDIT_USER_META_DATA : "edit_user_meta_data"


getMode = (mode) ->
	switch type
		WHEN "view" then return BOX_MODE.VIEW
		WHEN "edit_content" then return BOX_MODE.EDIT_CONTENT
		WHEN "edit_control_meta_data" then return BOX_MODE.EDIT_CONTROL_META_DATA
		WHEN "edit_user_meta_data" then return BOX_MODE.EDIT_USER_META_DATA

	console.log "Mode doesn't exist! (getMode)" 
	throw error

to_export =
	getMode : getMode

return to_export