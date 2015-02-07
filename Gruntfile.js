module.exports = function(grunt){
    grunt.initConfig({
	pkg : grunt.file.readJSON('package.json'),
	coffee : {
	    compile : {
		files : {
		    './final/scripts/Backend.js':'./src/boxlib/Backend.coffee',
		    './final/scripts/BoxAdministrator.js':'./src/boxlib/BoxAdministrator.coffee',
		    './final/scripts/Document.js':'./src/boxlib/Document.coffee',
		    './final/scripts/BoxMode.js':'./src/boxlib/BoxMode.coffee',
		    './final/scripts/BoxType.js':'./src/boxlib/BoxType.coffee',
		    './final/scripts/Box.js':'./src/boxlib/Box.coffee'
		}
	    }
	},
	jade : {
	    compile : {
		files : {
		    './final/HTMLbox/testBoxStyle.html' : './src/testStyl/testBoxStyle.jade'
		}
	    }
	},
	stylus : {
	    compile : {
		files : {
		    './final/css/box.css' : './src/style/box.styl'
		}
	    }
	},
	clean : ['./src/boxlib/*~','./final','*~']
    });

    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-contrib-stylus');
    grunt.loadNpmTasks('grunt-contrib-clean');
    
    grunt.registerTask('default',['coffee','jade','stylus']);
};
