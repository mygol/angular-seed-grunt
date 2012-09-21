module.exports = (grunt)->

	###############################################################
	# Constants
	###############################################################

	# Main src dirs
	SRC_ROOT= 'src/main'

	SRC_COFFEE_ROOT = "#{SRC_ROOT}/coffee"
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
					"target/main/js/": SRC_JS # note this isn't watched

		server:
			base: 'target/main'

		watch:
			coffee:
				files: SRC_COFFEE_ROOT
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
	grunt.registerTask('build_js', 'copy')
	grunt.registerTask('build_coffee', 'copy coffee:main')
	grunt.registerTask('default', 'clean build_js server watch')
	#grunt.registerTask('default', 'clean build_coffee server watch')
