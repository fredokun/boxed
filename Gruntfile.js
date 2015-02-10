module.exports = function(grunt){
    grunt.initConfig({
	pkg : grunt.file.readJSON('package.json'),
	coffee : {
	    compile : {
		files : {
		    './final/scripts/Controler.js':['./src/boxlib/BoxMode.coffee','./src/boxlib/BoxType.coffee','./src/boxlib/Box.coffee','./src/boxlib/BoxAdministrator.coffee','./src/boxlib/Document.coffee','./src/boxlib/Backend.coffee','./src/boxlib/JavascriptBackend.coffee','./src/boxlib/MardownBackend.coffee','./src/boxlib/Controler.coffee'],
		}
	    }
	},
	jade : {
	    compile : {
		files : {
		    './final/HTMLbox/testBoxStyle.html' : './src/testStyl/testBoxStyle.jade',
		    './final/index.html' : './src/model/index.jade'
		}
	    }
	},
	stylus : {
	    compile : {
		files : {
		    './final/css/box.css' : './src/style/box.styl',
		    './final/css/general.css' : './src/style/general.styl'
		}
	    }
	},
	clean : ['./src/boxlib/*~','./final','*~']
    });

    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-contrib-stylus');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    
    grunt.registerTask('default',['coffee','jade','stylus']);
};
