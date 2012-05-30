RedYarn = getModule "red-yarn"

client = RedYarn.makeClient "173.45.232.218:8080", (server) ->
  server.getServerTime (err, time) ->
    console.log "server time is #{time}"

client.getClientTime = (cb) ->
  cb null, Date.now()
