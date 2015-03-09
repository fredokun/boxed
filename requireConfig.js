
requirejs.config({
    shim : {
	'Document' : ['Box'],
	'MarkdownBackend' : ['Backend','commonmark'],
	'markdown' : ['CodeMirror'],
	'Controler' : ['jquery','Document','EventEmitter','MarkdownBackend','CodeMirror'],
	'BoXed': ['Controler']
    },
    paths : {
	jquery: './../../bower_components/jquery/dist/jquery',
	BoXed: 'BoXed',
	Controler:'Controler',
	Box: 'Box',
	Backend : 'Backend',
	MarkdownBackend : 'MarkdownBackend',
	EventEmitter : './../../node_modules/wolfy87-eventemitter/EventEmitter',    
	Document : 'Document',
	CodeMirror : './../../bower_components/codemirror/lib/codemirror',
	markdown : './../../bower_components/codemirror/mode/markdown/markdown',
	commonmark : './../../bower_components/commonmark/dist/commonmark' 
    }
}) ;
