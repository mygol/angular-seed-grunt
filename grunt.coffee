module.exports = (grunt)->

	###############################################################
	# Constants
	###############################################################

	# Main src dirs
	SRC_ROOT= 'src/main'

	SRC_COFFEE= "#{SRC_ROOT}/coffee/**"
	SRC_HTML = "#{SRC_ROOT}/html/**"
	SRC_CSS = "#{SRC_ROOT}/css/**"
	SRC_LIB = "#{SRC_ROOT}/lib/**"
	SRC_JS = "#{SRC_ROOT}/js/**"

	###############################################################
	# Config
	###############################################################

	grunt.initConfig

		clean:
			main: 'target/main'
			test: 'target/test'

		copy:
			main:
				files:
					"target/main/": SRC_HTML
					"target/main/css/": SRC_CSS
					"target/main/lib/": SRC_LIB # note this isn't watched
			js:
				files:
					"target/main/js/": SRC_JS # note this isn't watched

		coffee:
			main:
				options:
					bare: true
				src: SRC_COFFEE
				dest: 'target/main/js/'

			# If you don't want to use the coffeescript grunt file.
			jsGruntConfig:
				options:
					bare: true
				files:
					'grunt.js': 'grunt.coffee' 

		server:
			base: 'target/main'

		watch:
			coffee:
				files: SRC_COFFEE
				tasks: 'coffee'

			copy:
				files: [SRC_HTML, SRC_CSS]
				tasks: 'copy'


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
	grunt.registerTask('build_coffee', 'copy:main coffee:main')

	# Uncomment only one
	#grunt.registerTask('build', 'build_js')
	grunt.registerTask('build', 'build_coffee')

	grunt.registerTask('default', 'clean build server watch')
