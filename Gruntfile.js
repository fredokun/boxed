module.exports = function(grunt){
    grunt.initConfig({
	pkg : grunt.file.readJSON('package.json'),
	coffee : {
	    compile : {
		options: {
		    bare: true
		},
		files : {
		    './final/scripts/BoXed.js' : './src/boxlib/BoXed.coffee',
		    './final/scripts/Controler.js':'./src/boxlib/Controler.coffee',
		    './final/scripts/Box.js':'./src/boxlib/Box.coffee',
		    './final/scripts/Document.js':'./src/boxlib/Document.coffee',
		    './final/scripts/Backend.js':'./src/boxlib/Backend.coffee',
		    './final/scripts/MarkdownBackend.js':'./src/boxlib/MarkdownBackend.coffee'
		}
	    }
	},
	jade : {
	    compile : {
		files : {
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
	clean : ['./src/boxlib/*~','./final','*~'],
	requirejs : {
	    compile : {
		options: {
		    baseUrl: './final/scripts',
		    mainConfigFile: './requireConfig.js',
		    name: 'BoXed',
		    out: './final/scripts/BoXed.js'
		}
	    }
	}
    });

    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-contrib-stylus');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-requirejs');
    
    grunt.registerTask('default',['coffee','jade','stylus','requirejs']);
};
