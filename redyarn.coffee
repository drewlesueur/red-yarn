setModule "red-yarn", () ->
  _ = getModule "underscore"
  Rpc = getModule "rpc"
 
  giveRpcMyMethods = (server, rpc) -> 
    methods = _.methods(server)
    _.each methods, (method) -> rpc.methods[method] = server[method]
    methods

  setMyVisibleMethods = (server, client, rpc, callback) ->
    giveRpcMyMethods server, rpc
    rpc.send "__seeMyMethods", methods, (err) ->
      
  allowMeToSeeClientsMethods = (server, client, rpc) ->
    rpc.methods.__seeMyMethods = (methods, callback) ->
      _.each methods, (method) ->
        client[method] = (args..., cb) ->
          rpc.send method, args, cb
      _.defer callback
 
  createServer: (url, callback) ->
    server = {}
    server.connect = (client) -> # should be overridden
    server.clients = []
    ws = makeWebSocketServer url, () ->
      callback()
    wss.on "connection", (ws) ->
      client = {}
      client.ws = ws
      rpc = Rpc.createRpc()
      rpc.rawSend = (obj) -> ws.send JSON.stringify obj 
      allowMeToSeeClientsMethods server, client, rpc, (err) ->
        server.clients.push ws
        server.connect ws # connect method is a custom one by the user of this library
      
      console.log "**connection**"
      ws.on "message", (message) -> rpc.receive JSON.parse message
      setMyVisibleMethods server, client, rpc, (err) ->
      
    wss.on "close", (ws) ->
    wss.on "error", (ws) ->

    server

  createClient: (url, callback) ->
    client = {}
    ws = new WebSocket("ws://#{url}" )
    window.ws = ws
    ws.onopen = () ->
      console.log "opened"
      ws.send "algo from client"

    ws.onerror = () ->

    ws.onmessage =  (message) ->

    send = (info) ->
      ws.send JSON.stringify info


####################

getUrlInfo = (url) ->
  url or= ""
  splitUrl = url.split(":")

  host: splitUrl[0] or "127.0.0.1"
  port: splitUrl[1] or 80 

makeWebSocketServer = (url, callback) ->
  ws = getModule "ws"
  WebSocketServer = require("ws").Server
  {host, port} = getUrlInfo()
  wss = new WebSocketServer {port: port, host: host}, callback
  # "173.45.232.218"
  ws
