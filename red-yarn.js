(function() {

  setModule("red-yarn", function() {
    return {
      createConnection: function(url) {
        var redYarn;
        redYarn = {};
        redYarn.availableMethods = {};
        return redYarn.setMethods = function(methods) {};
      }
    };
  });

}).call(this);
