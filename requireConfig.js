requirejs.config({
    shim : {
	"Box" : [],
	"DocumentBox":["Box"],
	"CodeBox" : ["Box"],
	"Backend" : [],
	"LinkedBox" : [],
	"Presentor" : ["jquery","EventEmitter","cm/lib/CodeMirror"],
	"MarkdownBox" : ["DocumentBox"],
	"JavascriptBox" : ["CodeBox"],
	"Document" : ["LinkedBox","MarkdownBox","JavascriptBox"],
	"MarkdownBackend" : ["Backend","commonmark"],
	"JavascriptBackend" : ["Backend","commonmark"],
	"Controler" : ["jquery","Document","MarkdownBackend","JavascriptBackend","Presentor","EventEmitter"],
	"Boxed" : ["Controler"]
    },
    paths : {
	"jquery" : "./../bower_components/jquery/dist/jquery",
	"Box" : "Box",
	"DocumentBox":"DocumentBox",
	"CodeBox":"CodeBox",
	"Backend" : "Backend",
	"Presentor" : "Presentor",
	"LinkedBox" : "LinkedBox",
	"MarkdownBox" : "MarkdownBox",
	"JavascriptBox" : "JavascriptBox",
	"Document" : "Document",
	"MarkdownBackend" : "MarkdownBackend",
	"JavascriptBackend" : "JavascriptBackend",
	"Controler" : "Controler",
	"Boxed" : "Boxed",
	
	"cm" : "./../bower_components/codemirror",
	"commonmark" : "./../bower_components/commonmark/dist/commonmark",
	"EventEmitter" : "./../bower_components/eventEmitter/EventEmitter"
    }
}) ;
