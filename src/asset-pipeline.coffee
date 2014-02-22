OS        = require 'os'
RSVP      = require 'rsvp'
Path      = require 'path'
Utils     = require './utils'
Plugins   = require './plugins'
snockets  = new require 'snockets'

class AssetPipeline
  
  plugins   : {}

  defaults  : {
    assets_dir          : ['assets']
    auto_precompile_ext : ['.prod']
    precompile_files    : []
    precompile          : process.env == 'production'
  }

  constructor: (options = {})->
    @configure(options)

  configure: (options = {})->
    @options = Utils.extend(true, {}, @defaults, @options, options)

  will_precompile: (files)->
    Utils.add(@options.precompile_files, files)

  do_precompile:->
    console.log 'I will precompile your assets!'

  middleware: ->
    astppl = this
    return (req, res, next)->
      astppl.do_precompile(process.env)
      res.locals = Utils.extend(res.locals, astppl.helpers)
      next()

module.exports = new AssetPipeline
