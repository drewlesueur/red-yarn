RedYarn = getModule "red-yarn"

server = RedYarn.makeServer "173.45.232.218:8080", (clients) ->

server.connect = (client) ->
  client.getClientTime (err, time) ->
  console.log "a client conntected and his time is #{time}"

server.getServerTime = (cb) ->
  cb null, Date.now()
