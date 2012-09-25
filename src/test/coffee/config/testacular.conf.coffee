# Target Dir
basePath = '../../../'

files = [
  JASMINE,
  JASMINE_ADAPTER,
  'main/lib/angular/angular.js',
  'main/lib/angular/angular-*.js',
  'test/lib/angular/angular-mocks.js',
  'main/js/**/*.js',
  'test/js/unit/**/*.js'
]

autoWatch = false

browsers = ['Chrome']

junitReporter = {
  outputFile: 'test_out/unit.xml',
  suite: 'unit'
}
