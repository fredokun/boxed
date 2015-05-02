module.exports = function(grunt){
    grunt.initConfig({
    pkg : grunt.file.readJSON('package.json'),
    coffee : {
        compile : {
            options: {
                bare: true
            },
            files : {
                './scripts/Controler.js':'./sources/core/controler/Controler.coffee',
                './scripts/Boxed.js':'./sources/core/Boxed.coffee',

                './scripts/Presentor.js':'./sources/core/controler/presentors/Presentor.coffee',

                './scripts/Backend.js':'./sources/core/controler/backends/Backend.coffee',
                './scripts/MarkdownBackend.js':'./sources/core/controler/backends/MarkdownBackend.coffee',
                './scripts/JavascriptBackend.js':'./sources/core/controler/backends/JavascriptBackend.coffee',

                './scripts/Document.js':'./sources/core/model/Document.coffee',
                './scripts/Box.js':'./sources/core/model/boxes/Box.coffee',
                './scripts/DocumentBox.js':'./sources/core/model/boxes/DocumentBox.coffee',
                './scripts/CodeBox.js':'./sources/core/model/boxes/CodeBox.coffee',
                './scripts/JavascriptBox.js':'./sources/core/model/boxes/JavascriptBox.coffee',
                './scripts/MarkdownBox.js':'./sources/core/model/boxes/MarkdownBox.coffee',

                './scripts/DoublyChainedList.js':'./sources/core/utils/DoublyChainedList.coffee',
                './final/scripts/MouseListenner.js':'./sources/domListenner/MouseListenner.coffee',

                './scripts/NotDefineFunction.js':'./sources/core/utils/errors/NotDefineFunction.coffee',
                './scripts/NotDefineObject.js':'./sources/core/utils/errors/NotDefineObject.coffee',
                './scripts/IdAlreadyExists.js':'./sources/core/utils/errors/IdAlreadyExists.coffee'
            }
        }
    },
    jade : {
        compile : {
            files : {
                "./final/testView.html":"./sources/view/testView.jade",
                "./final/BoxedIndex.html":"./sources/view/BoxedIndex.jade"
            }
        },
        options : {
            pretty : true
        }
    },
    stylus : {
        compile : {
        files : {
            "./final/css/BoxedStyle.css":"./sources/view/BoxedStyle.styl"
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
            baseUrl: './scripts',
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