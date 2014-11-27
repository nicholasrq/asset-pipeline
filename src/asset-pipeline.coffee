OS        = require 'os'
RSVP      = require 'rsvp'
Path      = require 'path'
Utils     = require './utils'
Plugins   = require './plugins'
snockets  = new require 'snockets'
env       = process.env.NODE_ENV
root      = __dirname
app_root  = Path.join root#, '..', '..', '..'

class AssetPipeline
  
  VERSION   : require('../package.json').version

  plugins   : {}

  defaults  : {
    static_assets       : Path.join app_root, 'public', 'assets'
    assets_path         : '/assets'
    compiled            : '/public'
    assets_dir          : []
    auto_precompile_ext : ['.prod']
    precompile_files    : []
    precompile          : env == 'production'
  }

  set_app: (@exapp)->
    title = "Asset Pipleine v#{@VERSION} now"
    unless env == 'production'
      console.log "#{title} listens for requests on #{@options.assets_path}"
      @exapp.use(@options.assets_path, @listen())
    else
      console.log "#{title} serves static assets on #{@options.static_assets}"
      @exapp.use(@options.assets_path, @options.static_assets)

  constructor: (options = {})->
    @compiler = require './modules/compiler'
    @configure(options)

  configure: (options = {})->
    @options = Utils.extend({}, @defaults, @options, options)
    @assets  = require './modules/watch_assets'
    @assets.set_dir(@options.assets_dir)

    unless @options.precompile
      @assets.live()
    else
      @assets.index()

  will_precompile: (files)->
    Utils.add(@options.precompile_files, files)

  do_compile: (asset_path)->
    return new RSVP.Promise ((resolve, reject)->
      @assets.find(asset_path)
        .then(@compiler.process)
        .then((err, data)-> unless error? then resolve(data) else reject())
        .catch((err)-> reject(err))
    ).bind(this)

  listen: ->
    Server    = require './modules/server'
    @observer = Server.create(env, this)
    return @observer

  middleware: -> (req, res, next)->
    helpers     = require './modules/helpers'
    Object.keys(helpers).forEach((h)-> res.locals[h] = helpers[h])
    console.log res.locals
    next()


module.exports = new AssetPipeline
