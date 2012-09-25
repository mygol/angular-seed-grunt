module.exports = (grunt)->

   ###############################################################
   # Constants
   ###############################################################

   # Main src dirs
   SRC_ROOT= 'src/main'

   SRC_HTML = "#{SRC_ROOT}/html/**"
   SRC_CSS = "#{SRC_ROOT}/css/**"
   SRC_LIB = "#{SRC_ROOT}/lib/**"

   SRC_COFFEE_DIR= "#{SRC_ROOT}/coffee"
   SRC_COFFEE= "#{SRC_COFFEE_DIR}/**"
   SRC_JS = "#{SRC_ROOT}/js/**"

   # Test src dirs
   TEST_ROOT= 'src/test'

   TEST_HTML = "#{SRC_ROOT}/html/**"
   TEST_LIB = "#{TEST_ROOT}/lib/**"

   TEST_COFFEE_DIR= "#{TEST_ROOT}/coffee"
   TEST_COFFEE= "#{TEST_COFFEE_DIR}/**"
   TEST_JS = "#{TEST_ROOT}/js/**"

   TEST_CONFIG = "target/test/js/config/testacular.conf.js"
   TEST_E2E_CONFIG = "target/test/js/config/testacular-e2e.conf.js"

   ###############################################################
   # Config
   ###############################################################

   grunt.initConfig

      clean:
         main: 'target/main'
         test: 'target/test'

      copy:
         # handles html, css, and imgs, which (right now) don't go through any processing
         static:
            files:
               "target/main/": SRC_HTML
               "target/test/": TEST_HTML
               "target/main/css/": SRC_CSS
         # handles libs
         libs:
            files:
               "target/main/lib/": SRC_LIB
               "target/test/lib/": TEST_LIB
         # all js
         js:
            files:
               "target/main/js/": SRC_JS
               "target/test/js/": TEST_JS 
         # note no copy coffee - coffeescript files are 'copied' by the compiler

      coffee:
         main:
            options:
               bare: true
            src: SRC_COFFEE_DIR
            dest: 'target/main/js/'

         test:
            options:
               preserve_dirs: true
               base_path:TEST_COFFEE_DIR
               bare: true
            src: TEST_COFFEE
            dest: 'target/test/js/'

         # If you don't want to use the coffeescript grunt file.
         jsGruntConfig:
            options:
               bare: true
            files:
               'grunt.js': 'grunt.coffee' 

      server:
         base: 'target/main'

      watch:
         coffee_main:
            files: SRC_COFFEE
            tasks: 'coffee:main'

         coffee_test:
            files: TEST_COFFEE
            tasks: 'coffee:test'

         copy_static:
            files: [SRC_HTML, TEST_HTML, SRC_CSS]
            tasks: 'copy:static'

         copy_lib:
            files: [SRC_LIB, TEST_LIB]
            tasks: 'copy:lib'

         copy_js:
            files: [SRC_JS, TEST_JS]
            tasks: 'copy:js'

         # test anytime src changes.  Runs after copy!
         test:
            files: [SRC_JS, TEST_JS, SRC_COFFEE, TEST_COFFEE]
            tasks: 'test'

   ##############################################################
   # Custom Tasks
   ###############################################################

   # Stolen from https://github.com/pkozlowski-opensource/travis-play
   # commit 52fa175a57.  TODO move this to its own task project

   grunt.registerTask('testServer', 'Start Testacular server', (forWatch)->

      ###
      grunt.log.ok(forWatch)
      console.log(this)
      ###

      testacular = require('testacular');

      startTestacularServer = ()-> 
         testacular.server.start(configFile: TEST_CONFIG)

      if (forWatch)
         # start async
         done = this.async()
         setTimeout(()->
            startTestacularServer()
            done()
         , 100)

      else
         startTestacularServer()
   )

   grunt.registerTask('test', 'Run testacular tests', () ->

      travisArgs = ['start', '--single-run', '--no-auto-watch', '--reporter=dots', '--browsers=Firefox'] 

      testCmd = if process.platform == 'win32' then 'testacular.cmd' else 'testacular'
      testArgs = if process.env.TRAVIS then travisArgs else ['run']

      specDone = this.async()

      child = grunt.utils.spawn(
         {cmd: testCmd, args: testArgs}, (err, result, code) ->
            if code
               grunt.log.error("Test failed...", code) 
            specDone()
      )

      child.stdout.pipe(process.stdout)
      child.stderr.pipe(process.stderr)

   )

   ##############################################################
   # Dependencies
   ###############################################################
   grunt.loadNpmTasks('grunt-coffee');
   grunt.loadNpmTasks('grunt-contrib-copy')
   grunt.loadNpmTasks('grunt-contrib-clean')

   ###############################################################
   # Alias tasks
   ###############################################################

   # Supports both javascript and coffeescript
   grunt.registerTask('build_js', 'copy')
   grunt.registerTask('build_coffee', 'copy:main coffee:main coffee:test')

   # Uncomment only one
   grunt.registerTask('build', 'build_js')
   #grunt.registerTask('build', 'build_coffee')

   grunt.registerTask('default', 'clean build server testServer watch')
