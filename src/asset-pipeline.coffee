OS        = require 'os'
RSVP      = require 'rsvp'
Path      = require 'path'
Utils     = require './utils'
Plugins   = require './plugins'
snockets  = new require 'snockets'
env       = process.env.NODE_ENV
root      = __dirname

class AssetPipeline
  
  plugins   : {}

  defaults  : {
    static_assets       : Path.join root, '..', '..', '..', 'public', 'assets'
    assets_path         : '/assets'
    assets_dir          : ['assets']
    auto_precompile_ext : ['.prod']
    precompile_files    : []
    precompile          : env == 'production'
  }

  set_app: (@exapp)->
    unless env == 'production'
      console.log "Asset Pipleine now listens for
      requests on #{@options.assets_path}"
      @exapp.use(@options.assets_path, @listen())
    else
      console.log "Asset Pipleine now serves static
      assets on #{@options.static_assets}"
      @exapp.use(@options.assets_path, @options.static_assets)

  constructor: (options = {})->
    @configure(options)

  configure: (options = {})->
    @options = Utils.extend(true, {}, @defaults, @options, options)
    @assets  = 

  will_precompile: (files)->
    Utils.add(@options.precompile_files, files)

  do_compile: (asset_path)->
    return new RSVP.Promise ((resolve, reject)->
      resolve('yay!')
    ).bind(this)

  listen: ->
    Server    = require './modules/server'
    @observer = Server.create(env, this)
    return @observer

  middleware: ->
    astppl = this
    return (req, res, next)->
      res.locals = Utils.extend(res.locals, astppl.helpers)
      next()

module.exports = new AssetPipeline
