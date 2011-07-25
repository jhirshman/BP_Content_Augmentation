(function() {
  var Database, FileUtility, HyperPhysics, Owl, TermExtractor, Wikipedia, WolframMathWorld, Youtube, filePath, fileUtility, workers;
  TermExtractor = require('./workers/termExtractor');
  Youtube = require('./workers/youtube');
  WolframMathWorld = require('./workers/wolframMathWorld');
  HyperPhysics = require('./workers/hyperPhysics');
  Owl = require('./workers/owl');
  Wikipedia = require('./workers/wikipedia');
  Database = require('./utilities/database');
  FileUtility = require('./utilities/fileUtility');
  Database.clear();
  workers = {
    youtube: function() {
      return new Youtube(1);
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
      return new Wikipedia(1);
    }
  };
  if (true) {
    fileUtility = new FileUtility;
    filePath = __dirname + "/testHTML.html";
    fileUtility.readAndStripHTML(filePath, function(text) {
      return workers.termExtract().query(text, function(valid, output) {
        var myWorker, name, term, worker, _i, _len, _results;
        if (valid !== "true") {
          throw "error with extraction";
        }
        _results = [];
        for (_i = 0, _len = output.length; _i < _len; _i++) {
          term = output[_i];
          _results.push((function() {
            var _results2;
            _results2 = [];
            for (name in workers) {
              worker = workers[name];
              myWorker = worker();
              _results2.push(myWorker.subjects.science === true || myWorker.subjects.all === true ? (console.log("***" + name + ": " + term), myWorker.query(term, function(valid, results) {
                var data, _j, _len2, _results3;
                if (valid === "true") {
                  _results3 = [];
                  for (_j = 0, _len2 = results.length; _j < _len2; _j++) {
                    data = results[_j];
                    _results3.push(Database.insertIntoDB(data));
                  }
                  return _results3;
                } else {
                  return console.log(valid);
                }
              })) : void 0);
            }
            return _results2;
          })());
        }
        return _results;
      });
    });
  }
}).call(this);
