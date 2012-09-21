# angular-seed-grunt — 'angular-seed' wrapped in grunt

* [AngularJS](http://angularjs.org/) is a fantastic (dare I say the best!) web app Javascript framework
* [Grunt](http://gruntjs.com) is a fantastic (dare I say the best!) Javascript build tool
* [angular-seed](https://github.com/angular/angular-seed) is an application skeleton for a typical [AngularJS](http://angularjs.org/) web app.

## Motivation

angular-seed is a good starting place for an angularJS app but without being wrapped in a build,
it becomes difficult to see how it will grow, how you will put it inside your CI servers, how you
can add 'compile' steps such as minification, 'less' compilation, coffeescript compilation, etc.

## Status

This is still under heavy construction and is in a 'request for comments' state.  Please take part in discussions
[here](https://groups.google.com/forum/?fromgroups#!forum/angular).

### Outstanding Items

* Tests are not part of the build.  First phase is to integrate the test scripts into grunt, future phases
will be to use a possible testacular grunt plugin.
* Lint the javascript.
* Create a 'dist' target that demonstrates how grunt can minifiy, concat, uglify, etc. your code to make it
production-ready.

## Coffeescript support

angular-seed-grunt supports both javascript *and* coffeescript, dependening on which build you run.
Grunt will compile your coffeescript on the fly and will push only javascript to your browser as
you work.

You can delete any sections of the build that don't apply to you.  But try coffeescript.  It's fun ;)

## How to use angular-seed-grunt

First ensure that you have a working copy of [grunt](http://gruntjs.com) and [npm](https://npmjs.org/)
in your path.

After cloning the repository, run the `scripts/init-repo` script to ensure that grunt has all of the
dependencies that it needs for the build.

### Javascript build

By default the build will run in 'javascript' mode and will ignore the coffeescript files.  To run the default target, simply run `grunt`.  This will do the following:

* Clean the `target` directories, which is where all build artifacts go.
* Copy all html, js, css, etc to the target.
* Start a web server on port 8000.
* Start a watch that will update the target whenever your source files change.

### Coffeescript build

If you're more of a coffeescript person, edit the `grunt.coffee` file and register the `build` task to point 
to `build_coffee`.  Then run:

`grunt --config grunt.coffee` 

This will do the same as the javascript build above, but it will also listen for changes in your coffeescript
files, compile them to javascript, and push that javascript to your target.