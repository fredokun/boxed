requirejs.config({
    shim : {
    "NotDefineFunction": [],
    "NotDefineObject": [],
    "IdAlreadyExists":[],
    "Box" : ["NotDefineFunction","NotDefineObject"],
    "CodeBox" : ["Box"],
    "Backend" : ["NotDefineFunction"],
    "DoublyChainedList" : [],
    "Presentor" : ["jquery","EventEmitter","cm/lib/CodeMirror"],
    "MarkdownBox" : ["DocumentBox"],
    "JavascriptBox" : ["CodeBox"],
    "Document":["JavascriptBox","MarkdownBox","DoublyChainedList","NotDefineObject","IdAlreadyExists"],
    "MarkdownBackend" : ["Backend","commonmark"],
    "JavascriptBackend" : ["Backend"],
    "Controler" : ["Documnent","JavascriptBackend","MarkdownBackend","Presentor","EventEmitter"],
    "Boxed" : ["Controler"]
    },
    paths : {
    "NotDefineFunction": "NotDefineFunction",
    "NotDefineObject": "NotDefineObject",
    "IdAlreadyExists": "IdAlreadyExists",
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
    
    "cm" : "./../bower_components/codemirror",
    "commonmark" : "./../bower_components/commonmark/dist/commonmark",
    "EventEmitter" : "./../bower_components/eventEmitter/EventEmitter"
    }
}) ;