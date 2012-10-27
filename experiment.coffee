# node 1 (server)

me = node("http://some-site.drewl.us:8400")
me.on "connection", (other_node) -> other_node.on "bang", console.log
me.trigger "this just in", "its #{Date.now()}"
me.some_data = "stuff"
me.nested = {}
me.nested.a = 1
me.get_time = (cb) -> cb null, Date.now()
me.connections.on "bang", (them, data...) -> log "#{them} just blew!"

me.connections.on "get my time!", (them) ->
  them.get_client_time console.log


# node 2 (client 1)
me = node()
them = find_node("http://some-site.drewl.us:8400")
# will queue up commands if not connected
them.get_time (err, time) -> console.log time
me.get_client_time = (cb) -> cb null, Date.now()
them.on "this just in", console.log

them.nested.a.on "change", console.log

them.players.on "add", ()

# sincing with my datasync project
  

# later on
me.trigger "get my time!"




them.on "this just in", ->
  console.log "something was just in!"
them.some_data 



# node 3 (client 2)


