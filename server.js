(function() {
  var RedYarn;

  require("./poor-module.js");

  require("./red-yarn.js");

  RedYarn = getModule("red-yarn");

}).call(this);
