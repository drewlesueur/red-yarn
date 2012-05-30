(function() {
  var getUrlInfo, makeWebSocketServer,
    __slice = Array.prototype.slice;

  setModule("red-yarn", function() {
    var Rpc, allowMeToSeeClientsMethods, giveRpcMyMethods, setMyVisibleMethods, _;
    _ = getModule("underscore");
    Rpc = getModule("rpc");
    giveRpcMyMethods = function(server, rpc) {
      var methods;
      methods = _.methods(server);
      _.each(methods, function(method) {
        return rpc.methods[method] = server[method];
      });
      return methods;
    };
    setMyVisibleMethods = function(server, client, rpc, callback) {
      giveRpcMyMethods(server, rpc);
      return rpc.send("__seeMyMethods", methods, function(err) {});
    };
    allowMeToSeeClientsMethods = function(server, client, rpc) {
      return rpc.methods.__seeMyMethods = function(methods, callback) {
        _.each(methods, function(method) {
          return client[method] = function() {
            var args, cb, _i;
            args = 2 <= arguments.length ? __slice.call(arguments, 0, _i = arguments.length - 1) : (_i = 0, []), cb = arguments[_i++];
            return rpc.send(method, args, cb);
          };
        });
        return _.defer(callback);
      };
    };
    return {
      createServer: function(url, callback) {
        var server, ws;
        server = {};
        server.connect = function(client) {};
        server.clients = [];
        ws = makeWebSocketServer(url, function() {
          return callback();
        });
        wss.on("connection", function(ws) {
          var client, rpc;
          client = {};
          client.ws = ws;
          rpc = Rpc.createRpc();
          rpc.rawSend = function(obj) {
            return ws.send(JSON.stringify(obj));
          };
          allowMeToSeeClientsMethods(server, client, rpc, function(err) {
            server.clients.push(ws);
            return server.connect(ws);
          });
          console.log("**connection**");
          ws.on("message", function(message) {
            return rpc.receive(JSON.parse(message));
          });
          return setMyVisibleMethods(server, client, rpc, function(err) {});
        });
        wss.on("close", function(ws) {});
        wss.on("error", function(ws) {});
        return server;
      },
      createClient: function(url, callback) {
        var client, send, ws;
        client = {};
        ws = new WebSocket("ws://" + url);
        window.ws = ws;
        ws.onopen = function() {
          console.log("opened");
          return ws.send("algo from client");
        };
        ws.onerror = function() {};
        ws.onmessage = function(message) {};
        return send = function(info) {
          return ws.send(JSON.stringify(info));
        };
      }
    };
  });

  getUrlInfo = function(url) {
    var splitUrl;
    url || (url = "");
    splitUrl = url.split(":");
    return {
      host: splitUrl[0] || "127.0.0.1",
      port: splitUrl[1] || 80
    };
  };

  makeWebSocketServer = function(url, callback) {
    var WebSocketServer, host, port, ws, wss, _ref;
    ws = getModule("ws");
    WebSocketServer = require("ws").Server;
    _ref = getUrlInfo(), host = _ref.host, port = _ref.port;
    wss = new WebSocketServer({
      port: port,
      host: host
    }, callback);
    return ws;
  };

}).call(this);
