BOX_TYPE = 
	MARKDOWN : "markdown"
	JAVASCRIPT : "javascript"

getType = (type) ->
	switch type
		WHEN "markdown" then return BOX_TYPE.MARKDOWN
		WHEN "javascript" then return BOX_TYPE.JAVASCRIPT

	console.log "Type doesn't exist! (getType)" 
	throw error

to_export =
	getType : getType
	BOX_TYPE : BOX_TYPE

return to_export