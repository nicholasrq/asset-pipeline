RSVP  = require 'rsvp'
Utils = require '../utils'

class WatchAssets
  assets_index = {
    assets     : {}
    dependencies : {}
  }

  constructor: (extensions)->
    @dirs = []

  live: ->
    @remove_listeners()
    @add_listeners()
    @index()

  index: ->
    build_index = new RSVP.Promise(((resolve, reject)=>
      files = @dirs.reduce ((list, dir)->
        files_list = Utils.files(dir).reduce(((res, file_path)->
          asset_path = file_path.replace(dir + '/', '')
          res[asset_path] = file_path
          return res
        ), {})
        return list.concat(files_list)
      ), []
      resolve(files)
    ))

    build_index
      .then(@save_index.bind(this))
      .catch(@handle_errors)

  find: (path)->
    console.log "Try to find #{path}"

  save_index: (files)->
    console.log files

  add_listeners: ->

  remove_listeners: ->

  handle_errors: (err)->
    console.error err.stack

  set_dir: (dirs)->
    if typeof dirs == 'string'
      @dirs = [dirs]
    else if Array.isArray(dirs)
      @dirs = dirs


module.exports = new WatchAssets
