requirejs.config({
    shim : {
    "Box" : [],
    "CodeBox" : ["Box"],
    "Backend" : [],
    "DoublyChainedList" : [],
    "Presentor" : ["jquery","EventEmitter","cm/lib/CodeMirror"],
    "MarkdownBox" : ["DocumentBox"],
    "JavascriptBox" : ["CodeBox"],
    "Document":["JavascriptBox","MarkdownBox","DoublyChainedList"],
    "MarkdownBackend" : ["Backend","commonmark"],
    "JavascriptBackend" : ["Backend"],
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
    "DoublyChainedList" : "DoublyChainedList",
    "MarkdownBox" : "MarkdownBox",
    "JavascriptBox" : "JavascriptBox",
    "Document" : "Document",
    "MarkdownBackend" : "MarkdownBackend",
    "JavascriptBackend" : "JavascriptBackend",
    "Controler" : "Controler",
    "Boxed" : "Boxed",
    
    "cm" : "./../bower_components/CodeMirror",
    "commonmark" : "./../bower_components/commonmark/dist/commonmark",
    "EventEmitter" : "./../bower_components/eventEmitter/EventEmitter"
    }
}) ;
