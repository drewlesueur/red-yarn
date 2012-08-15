require "./poor_modules/poor-module.js"
require "./red-yarn.js"
require "./rpc.js"

_ = require "underscore"
ws = require "ws"

poorModule "underscore", -> _
poorModule "ws", -> ws

require "./server-example.js"
