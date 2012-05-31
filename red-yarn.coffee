setModule "red-yarn", () ->
  _ = getModule "underscore"
  Rpc = getModule "rpc"

  giveRpcMyMethods = (me, rpc) -> 
    methods = _.methods(me)
    _.each methods, (method) -> rpc.methods[method] = me[method]
    methods

  createServer: (url, callback) ->
    server = {}
    server.connect = (client) -> # should be overridden
    server.clients = []
    wss = makeWebSocketServer url, () ->
    wss.on "connection", (ws) ->
      client = {}
      client.ws = ws
      rpc = Rpc.create()
      giveRpcMyMethods server, rpc
      rpc.rawSend = (obj) -> ws.send JSON.stringify obj 
      client.call = (method, args..., callback) -> rpc.send method, args, callback
      server.clients.push ws
      server.connect client # connect method is a custom one by the user of this library
      console.log "**connection**"
      ws.on "message", (message) -> rpc.receive JSON.parse message
      callback(null, client)
    wss.on "close", (ws) ->
    wss.on "error", (ws) ->
    server

  createClient: (url, callback) ->
    client = {}
    ws = new WebSocket("ws://#{url}" )
    window.ws = ws
    rpc =  Rpc.create()
    ws.onopen = () ->
      server = {}
      rpc = Rpc.create()
      giveRpcMyMethods client, rpc
      rpc.rawSend = (obj) -> ws.send JSON.stringify obj 
      server.call = (method, args..., callback) -> rpc.send method, args, callback
      callback null, server

    ws.onmessage =  (event) -> rpc.receive JSON.parse event.data
    ws.onerror = () ->
    client

####################

getUrlInfo = (url) ->
  url or= ""
  splitUrl = url.split(":")
  host: splitUrl[0] or "127.0.0.1"
  port: splitUrl[1] or 80 

makeWebSocketServer = (url, callback) ->
  ws = getModule "ws"
  WebSocketServer = require("ws").Server
  {host, port} = getUrlInfo(url)
  wss = new WebSocketServer {port: port, host: host}, callback
  # "173.45.232.218"
  wss
