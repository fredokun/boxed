requirejs.config({
    shim : {
	'Boxed':['Controler'],
	'Controler' : ['jquery']
    },
    paths : {
	jquery: './../../bower_components/jquery/dist/jquery',
	Boxed: 'Boxed',
	Controler:'Controler'
    }
}) ;
