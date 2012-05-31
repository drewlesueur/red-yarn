require "./poor-module.js"
require "./red-yarn.js"
require "./rpc.js"

_ = require "underscore"
ws = require "ws"

setModule "underscore", -> _
setModule "ws", -> ws

require "./server-example.js"
