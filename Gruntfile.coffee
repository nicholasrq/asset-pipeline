fs          = require('fs')
path        = require('path')
join_path   = path.join

module.exports = (grunt) ->

  grunt.initConfig {
    pkg     : grunt.file.readJSON('package.json')
    coffee  :
      compile:
        expand: true,
        cwd: 'src',
        src: ['**/*.coffee'],
        dest: 'lib',
        ext: '.js'

    coffeelint:
      build:
        src: ['src/**/*.coffee']
        options: {
          'no_trailing_whitespace': {
            'level': 'ignore'
          }
        }
  }

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-jslint'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask 'default', ['coffeelint:build', 'coffee:compile']
