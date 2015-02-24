
requirejs.config({
    shim : {
	'Box' : ['EventEmitter'],
	'Document' : ['Box'],
	'MarkdownBackend' : ['Backend','commonmark'],
	'Controler' : ['jquery','Document','EventEmitter','CodeMirror','MarkdownBackend'],
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
	commonmark : './../../bower_components/commonmark/dist/commonmark' 
    }
}) ;
