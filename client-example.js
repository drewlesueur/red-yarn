(function() {
  var RedYarn, client;

  RedYarn = getModule("red-yarn");

  client = RedYarn.createClient("drewl.us:9002", function(err, server) {
    return server.call("getServerTime", function(err, time) {
      return console.log("server time is " + time);
    });
  });

  client.getClientTime = function(cb) {
    cb(null, Date.now());
    return console.log("the server got my time!");
  };

}).call(this);
