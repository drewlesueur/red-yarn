(function() {
  var ws, _;

  require("./poor_modules/poor-module.js");

  require("./red-yarn.js");

  require("./rpc.js");

  _ = require("underscore");

  ws = require("ws");

  poorModule("underscore", function() {
    return _;
  });

  poorModule("ws", function() {
    return ws;
  });

  require("./server-example.js");

}).call(this);
