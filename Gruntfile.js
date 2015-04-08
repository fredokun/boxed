module.exports = function(grunt){
    grunt.initConfig({
	pkg : grunt.file.readJSON('package.json'),
	coffee : {
	    compile : {
		options: {
		    bare: true
		},
		files : {
		    './pre/Controler.js':'./sources/core/controler/Controler.coffee',
		    './pre/Boxed.js':'./sources/core/controler/Boxed.coffee',

		    './pre/Presentor.js':'./sources/core/controler/presentors/Presentor.coffee',

		    './pre/Backend.js':'./sources/core/controler/backends/Backend.coffee',
		    './pre/MarkdownBackend.js':'./sources/core/controler/backends/MarkdownBackend.coffee',
		    './pre/JavascriptBackend.js':'./sources/core/controler/backends/JavascriptBackend.coffee',

		    './pre/Document.js':'./sources/core/model/Document.coffee',
		    './pre/Box.js':'./sources/core/model/boxes/Box.coffee',
		    './pre/DocumentBox.js':'./sources/core/model/boxes/DocumentBox.coffee',
		    './pre/CodeBox.js':'./sources/core/model/boxes/CodeBox.coffee',
		    './pre/JavascriptBox.js':'./sources/core/model/boxes/JavascriptBox.coffee',
		    './pre/MarkdownBox.js':'./sources/core/model/boxes/MarkdownBox.coffee',

		    './pre/LinkedBox.js':'./sources/core/utils/LinkedBox.coffee',
		    './final/scripts/MouseListenner.js':'./sources/domListenner/MouseListenner.coffee'
		    
		}
	    }
	},
	jade : {
	    compile : {
		files : {
		    "./final/Boxed.html":"./sources/view/Boxed.jade",
		}
	    }
	},
	stylus : {
	    compile : {
		files : {
		    "./final/css/index.css":"./sources/view/index.styl"
		}
	    }
	},
	auto_install: {
   	    local: {},
    	    subdir: {
      		options: {
        	    cwd: '',
        	    stdout: true,
        	    stderr: true,
        	    failOnError: true,
        	    npm: '--production'
      		}	
    	    }
  	},
	clean : ['./sources/core/controler/*~','./sources/core/controler/backends/*~','./sources/core/controler/presentors/*~','./sources/core/model/*~','./sources/core/model/boxes/*~','./sources/core/utils/*~','*~','./final','./pre','./scripts','./sources/view/*~'],
	requirejs : {
	    compile : {
		options: {
		    baseUrl: './pre',
		    mainConfigFile: './requireConfig.js',
		    name: 'Boxed',
		    out: './final/scripts/Boxed.js'
		}
	    }
	}
    });

    grunt.loadNpmTasks('grunt-auto-install');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-jade');
    grunt.loadNpmTasks('grunt-contrib-stylus');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-requirejs');
    
    grunt.registerTask('default',['coffee','jade','stylus','requirejs']);
}
