(function() {
  var RedYarn, client;

  RedYarn = getModule("red-yarn");

  client = RedYarn.makeClient("173.45.232.218:8080", function(server) {
    return server.getServerTime(function(err, time) {
      return console.log("server time is " + time);
    });
  });

  client.getClientTime = function(cb) {
    return cb(null, Date.now());
  };

}).call(this);
