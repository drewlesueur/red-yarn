RedYarn = poorModule "red-yarn"

server = RedYarn.createServer "drewl.us:9002", (err, client) ->
  client.call "getClientTime", (err, time) ->
    console.log "a client conntected and his time is #{time}"

server.getServerTime = (cb) ->
  cb null, Date.now()
