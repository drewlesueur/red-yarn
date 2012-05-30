(function() {
  var RedYarn, server;

  RedYarn = getModule("red-yarn");

  server = RedYarn.makeServer("173.45.232.218:8080", function(clients) {});

  server.connect = function(client) {
    client.getClientTime(function(err, time) {});
    return console.log("a client conntected and his time is " + time);
  };

  server.getServerTime = function(cb) {
    return cb(null, Date.now());
  };

}).call(this);
