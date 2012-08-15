RedYarn = poorModule "red-yarn"

client = RedYarn.createClient "drewl.us:9002", (err, server) ->
  server.call "getServerTime", (err, time) ->
    console.log "server time is #{time}"

client.getClientTime = (cb) ->
  cb null, Date.now()
  console.log "the server got my time!"
