(function() {
  var ws, _;

  require("./poor-module.js");

  require("./red-yarn.js");

  require("./rpc.js");

  _ = require("underscore");

  ws = require("ws");

  setModule("underscore", function() {
    return _;
  });

  setModule("ws", function() {
    return ws;
  });

  require("./server-example.js");

}).call(this);
