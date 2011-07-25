(function() {
  var HyperPhysics, Owl, TermExtractor, Wikipedia, WolframMathWorld, WorkForce, Youtube;
  TermExtractor = require('./termExtractor');
  Youtube = require('./youtube');
  WolframMathWorld = require('./wolframMathWorld');
  HyperPhysics = require('./hyperPhysics');
  Owl = require('./owl');
  Wikipedia = require('./wikipedia');
  module.exports = WorkForce = (function() {
    function WorkForce() {}
    WorkForce.prototype.workers = {
      youtube: function() {
        return new Youtube(5);
      },
      termExtract: function() {
        return new TermExtractor(2);
      },
      wolframMW: function() {
        return new WolframMathWorld(1);
      },
      hyperPhysics: function() {
        return new HyperPhysics(1);
      },
      owl: function() {
        return new Owl(1);
      },
      wikipedia: function() {
        return new Wikipedia(3);
      }
    };
    WorkForce.prototype.extractTermsAndGetData = function(text, subject, action) {
      var me;
      me = this;
      return this.extractTerms(text, function(terms) {
        return me.getData(terms, subject, action);
      });
    };
    WorkForce.prototype.extractTerms = function(text, callback) {
      return this.workers.termExtract().query(text, function(valid, terms) {
        if (valid !== "true") {
          throw "error with extraction";
        }
        return callback(terms);
      });
    };
    WorkForce.prototype.getData = function(terms, subject, action) {
      var myWorker, name, term, worker, _i, _len, _results;
      if (subject == null) {
        subject = "generic";
      }
      if (action == null) {
        action = function(data) {
          return console.log(data);
        };
      }
      _results = [];
      for (_i = 0, _len = terms.length; _i < _len; _i++) {
        term = terms[_i];
        _results.push((function() {
          var _ref, _results2;
          _ref = this.workers;
          _results2 = [];
          for (name in _ref) {
            worker = _ref[name];
            myWorker = worker();
            _results2.push(myWorker.subjects[subject] === true || myWorker.subjects.all === true ? (console.log("***" + name + ": " + term), myWorker.query(term, function(valid, results) {
              var data, _j, _len2, _results3;
              if (valid === "true") {
                _results3 = [];
                for (_j = 0, _len2 = results.length; _j < _len2; _j++) {
                  data = results[_j];
                  _results3.push(action(data));
                }
                return _results3;
              } else {
                return console.log(valid);
              }
            })) : void 0);
          }
          return _results2;
        }).call(this));
      }
      return _results;
    };
    return WorkForce;
  })();
}).call(this);
