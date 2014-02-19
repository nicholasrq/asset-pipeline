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
  }

  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default', ['coffee:compile']
