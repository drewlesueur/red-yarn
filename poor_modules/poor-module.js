;(function (root) {
var _poorModule = root._poorModule = {}
, defs = _poorModule.defs = {}, modules = _poorModule.modules = {}
, poorModule = root.poorModule = _poorModule.poorModule = function (name, fn) {
  if (fn) { defs[name] = fn; delete modules[name]; }
  else {
    if (modules.hasOwnProperty(name)) return modules[name];
    if (defs.hasOwnProperty(name)) {
      var fn = defs[name];
      defs[name] = function () { throw new Error("Circular Dependency"); }
      return modules[name] = fn();
    } throw new Error("Module not found: " + name); }
}})(typeof window !== "undefined" && window !== null ? window : typeof global !== "undefined" && global !== null ? global : this);
