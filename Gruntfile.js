module.exports = function(grunt){
    grunt.initConfig({
	pkg : grunt.file.readJSON('package.json'),
	coffee : {
	    compile : {
		options: {
		    bare: true
		},
		files : {
		    './final/scripts/Boxed.js' : './src/boxlib/Boxed.coffee',
		    './final/scripts/Controler.js':'./src/boxlib/Controler.coffee',
		    './final/scripts/draw.js':'./src/boxlib/drawn.coffee'
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
