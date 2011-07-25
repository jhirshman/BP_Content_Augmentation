(function() {
  var Worker, http, queryString;
  queryString = require("querystring");
  http = require("http");
  module.exports = Worker = (function() {
    function Worker(limit) {
      if (limit == null) {
        limit = 5;
      }
      this.requestOptions = {
        host: "",
        port: 80,
        path: "",
        headers: {
          "user-agent": "BenchPrep content augmentation client contact @ chicago@benchprep.com"
        }
      };
      this.pathParts = {
        base: "",
        options: {}
      };
      this.subjects = {
        math: false,
        science: false,
        english: false,
        writing: false,
        all: false
      };
      this.limit = limit;
      this.workerID = "worker";
      this.workerName = "Worker";
    }
    Worker.prototype.query = function(query, callback) {
      var req, worker;
      worker = this;
      this.queryText = query;
      this.callback = callback;
      this.enterQueryinPath(query);
      this.requestOptions.path = this.pathParts.base + queryString.stringify(this.pathParts.options);
      return req = http.get(this.requestOptions, function(response) {
        var text;
        text = "";
        response.on("data", function(data) {
          return text += data;
        });
        return response.on("end", function() {
          var jsonData;
          try {
            jsonData = eval('(' + text + ')');
          } catch (e) {
            worker.callback("not valid JSON", "");
          }
          return worker.validateData(jsonData, function(valid, outputData) {
            worker.valid = valid;
            worker.output = outputData;
            if (valid === "true") {
              return worker.callback("true", outputData);
            } else {
              return worker.callback(valid, "");
            }
          });
        });
      });
    };
    Worker.prototype.enterQueryinPath = function() {
      return this.queryText;
    };
    Worker.prototype.validateData = function(jsonData, callback) {};
    Worker.prototype.getOutput = function() {};
    Worker.prototype.applyLimit = function(output) {
      if (this.limit < 1) {
        return output.slice(0, 1);
      }
      return output.slice(0, this.limit);
    };
    return Worker;
  })();
}).call(this);
