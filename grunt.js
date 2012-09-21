/* NOTE this file was automatically generated from the grunt.coffee file.
   if you run grunt coffee:jsGruntConfig, you'll regenerate it!
*/
module.exports = function(grunt) {
  /* Constants
  */

  var SRC_COFFEE_ROOT, SRC_CSS, SRC_HTML, SRC_JS, SRC_LIB, SRC_ROOT;
  SRC_ROOT = 'src/main';
  SRC_COFFEE_ROOT = "" + SRC_ROOT + "/coffee";
  SRC_HTML = "" + SRC_ROOT + "/html/**";
  SRC_CSS = "" + SRC_ROOT + "/css/**";
  SRC_LIB = "" + SRC_ROOT + "/lib/**";
  SRC_JS = "" + SRC_ROOT + "/js/**";
  /* Config
  */

  grunt.initConfig({
    clean: {
      main: 'target/main',
      test: 'target/test'
    },
    coffee: {
      main: {
        options: {
          bare: true
        },
        files: {
          'target/main/js/app.js': ["" + SRC_COFFEE_ROOT + "/modules/**", "" + SRC_COFFEE_ROOT + "/app.coffee"]
        }
      },
      jsGruntConfig: {
        options: {
          bare: true
        },
        files: {
          'grunt.js': 'grunt.coffee'
        }
      }
    },
    concat: {
      main: {
        src: SRC_JS,
        dest: 'target/main/js/app.js'
      }
    },
    copy: {
      main: {
        files: {
          "target/main/": SRC_HTML,
          "target/main/css/": SRC_CSS,
          "target/main/lib/": SRC_LIB
        }
      }
    },
    server: {
      base: 'target/main'
    },
    watch: {
      coffee: {
        files: SRC_COFFEE_ROOT,
        tasks: 'coffee'
      },
      copy: {
        files: [SRC_HTML, SRC_CSS],
        tasks: 'copy'
      }
    }
  });
  /* Dependencies
  */

  grunt.loadNpmTasks('grunt-coffee');
  grunt.loadNpmTasks('grunt-contrib');
  /* Alias tasks
  */

  grunt.registerTask('build_js', 'copy concat');
  grunt.registerTask('build_coffee', 'copy coffee:main');
  return grunt.registerTask('default', 'clean build_coffee server watch');
};
