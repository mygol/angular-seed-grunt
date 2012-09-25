# angular-seed-grunt — 'angular-seed' wrapped in grunt

* [AngularJS](http://angularjs.org/) is a fantastic (dare I say the best!) web app Javascript framework
* [Grunt](http://gruntjs.com) is a fantastic (dare I say the best!) Javascript build tool
* [angular-seed](https://github.com/angular/angular-seed) is an application skeleton for a typical [AngularJS](http://angularjs.org/) web app.

## Motivation

angular-seed is a good starting place for an angularJS app but without being wrapped in a build,
it becomes difficult to see how it will grow, how you will put it inside your CI servers, how you
can add 'compile' steps such as minification, 'less' compilation, coffeescript compilation, etc.

### What about Yeoman?

Per [their blog](http://blog.angularjs.org/2012/09/yeoman-and-angularjs.html), Angular plans on deprecating 
angular-seed some day in favor of a [Yeoman](http://yeoman.io/) generator.  So why this project?

* Yeoman does not support Windows, and in a corporate env, many developers are still coding on Windows (including me)
* Yeoman has a large footprint (10 - 15 min unattended install per their video).  No way I can convince my SA's that I need ruby (and whatever else) on 50 developer machines when we're not coding ruby.

The shorter answer is - grunt is light and easy.  Hopefully someday our paths will merge.

## What does it do that angular-seed doesn't?

* Provides a watch loop for both javascript and coffeescript that will compile, delint, and test your code as you save.  Tests are run with testacular.

### What's still to do?

* End-to-end tests
* Add a [less](http://lesscss.org/) sample
* Create a 'dist' target that demonstrates how grunt can minifiy, concat, uglify, etc. your code to make it
production-ready
* Make it CI friendly

## How to use angular-seed-grunt

### Initial setup

1. Ensure that you have [node](http://nodejs.org/), [npm](https://npmjs.org/), and [grunt](http://gruntjs.com/) installed and in your path
1. Clone this repository
1. Run `npm install` to pull down all dependencies

### Javascript build

By default the build will run in 'javascript' mode and will ignore the coffeescript files.  To run the default target, simply run `grunt`.  This will do the following:

* Clean the `target` directories, which is where all build artifacts go.
* Copy all html, js, css, etc to the target.
* Start a web server on port 8000.
* Start a Testacular server on port 9876.
* Start a watch that will copy, lint, and test every change you make.

To ensure that your tests run, make sure a browser window is open to `localhost:9876`

### Coffeescript build

If you're more of a coffeescript person, edit the `grunt.coffee` file and register the `build` task to point 
to `build_coffee`.  Then run:

`grunt --config grunt.coffee` 

This will do the same as the javascript build above, but it will also listen for changes in your coffeescript
files, compile them to javascript, and push that javascript to your target.  Any javascript with the same name will be overwritten.

Enjoy!