module.exports = function(grunt){
    grunt.initConfig({
	pkg : grunt.file.readJSON('package.json'),
	coffee : {
	    compile : {
		files : {
		    './final/scripts/Box.js':'./src/boxlib/Box.coffee'
		}
	    }
	}
    });

    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.registerTask('default',['coffee']);
};
