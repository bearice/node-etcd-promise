Etcd = require 'node-etcd'
Promise = require 'promise'

class EtcdPromise
  constructor: ->
    @etcd = Object.create Etcd.prototype
    Etcd.apply @etcd, arguments

  raw:    => @_mkPromise('raw', arguments)
  get:    => @_mkPromise('get', arguments)
  set:    => @_mkPromise('set', arguments)
  del:    => @_mkPromise('del', arguments)
  mkdir:  => @_mkPromise('mkdir', arguments)
  rmdir:  => @_mkPromise('rmdir', arguments)
  create: => @_mkPromise('create', arguments)
  watch:  => @_mkPromise('watch', arguments)
  watchIndex: => @_mkPromise('watchIndex', arguments)
  compareAndSwap:   => @_mkPromise('compareAndSwap', arguments)
  compareAndDelete: => @_mkPromise('compareAndDelete', arguments)

  post: @::create
  delete: @::del
  testAndSet: @::compareAndSwap
  testAndDelete: @::compareAndDelete

  machines:    => @_mkPromise('machines', arguments)
  leader:      => @_mkPromise('leader', arguments)
  leaderStats: => @_mkPromise('leaderStats', arguments)
  selfStats:   => @_mkPromise('selfStats', arguments)
  version:     => @_mkPromise('version', arguments)

  _mkPromise: (name,args) ->
    args = Array.prototype.slice.call args
    console.info name,args if process.env.DEBUG_ETCD
    new Promise (accept,reject)=>
      args.push (err,resp,body)->
        return reject(err) if err
        return accept({resp: resp, body: body})
      @etcd[name].apply(@etcd,args)

  watcher: => @_proxy('watcher',arguments)
  getHosts: => @_proxy('getHosts',arguments)

  _proxy: (name,args) ->
    @etcd[name].apply(@etcd,args)

module.exports = EtcdPromise
