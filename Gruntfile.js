module.exports = function(grunt){
	grunt.initConfig({
		pkg : grunt.file.readJSON('package.json'),
		coffee : {
			compile : {
				options: {
					bare: true
				},
				files : {
				}
			}
		},
		jade : {
			pretty : {
				files : {
				},
				options	 : {
					pretty : true
				}
			}
		},
		stylus : {
			compile : {
				files : {
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
  		}
	});

	grunt.loadNpmTasks('grunt-contrib-jade');
	grunt.loadNpmTasks('grunt-contrib-stylus');
	grunt.loadNpmTasks('grunt-contrib-coffee');

	grunt.loadNpmTasks('grunt-contrib-clean');

	grunt.loadNpmTasks('grunt-auto-install');

	grunt.loadNpmTasks('grunt-contrib-requirejs');

	grunt.registerTask('default',['auto_install','coffee','jade','stylus','requirejs']);

};

