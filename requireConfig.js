requirejs.config({
    shim : {
	'Box' : ['EventEmitter'],
	'Document' : ['Box','EventEmitter'],
	'Controler' : ['jquery','Document','EventEmitter','CodeMirror'],
	'BoXed': ['Controler']
    },
    paths : {
	jquery: './../../bower_components/jquery/dist/jquery',
	BoXed: 'BoXed',
	Controler:'Controler',
	Box: 'Box',
	EventEmitter : './../../node_modules/wolfy87-eventemitter/EventEmitter',    
	Document : 'Document',
	CodeMirror : './../../bower_components/codemirror/lib/codemirror'
    }
}) ;
