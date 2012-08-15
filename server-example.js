(function() {
  var RedYarn, server;

  RedYarn = poorModule("red-yarn");

  server = RedYarn.createServer("drewl.us:9002", function(err, client) {
    return client.call("getClientTime", function(err, time) {
      return console.log("a client conntected and his time is " + time);
    });
  });

  server.getServerTime = function(cb) {
    return cb(null, Date.now());
  };

}).call(this);
