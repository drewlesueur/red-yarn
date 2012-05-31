setModule "rpc", () ->
  create: ->
    self = {}
    self.callbacks = {}
    self.methods = {}

    uuid = ->
      #http://stackoverflow.com/questions/105034/how-to-create-a-guid-uuid-in-javascript
      `'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {var r = Math.random()*16|0,v=c=='x'?r:r&0x3|0x8;return v.toString(16);});` 
            
    self.rawSend = ->
    
    self.receive = (obj) =>
      if obj.result or obj.error
        {result, error, id} = obj 
        self.callbacks[id]?(error, result)
        delete self.callbacks[id]
      else if obj.method
        {method, params, id} = obj 
        cb = (err, result) =>
          self.rawSend
            result: result
            error: err
            id: id

        self.methods[method]? params..., cb
        return cb

    self.send = (method, args, callback) =>
      self.lastId = uuid()
      # todo: make callback optional
      self.callbacks[self.lastId] = callback

      self.rawSend
        method: method
        params: args
        id: self.lastId

    self
