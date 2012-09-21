REM See http://stackoverflow.com/q/12484929/295797

del /S /Q node_modules

npm.cmd install ^
	grunt-contrib-clean ^
	grunt-coffee ^
	grunt-contrib-copy