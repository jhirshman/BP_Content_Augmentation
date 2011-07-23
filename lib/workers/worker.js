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
        "user-agent": "BenchPrep content augmentation client contact @ chicago@benchprep.com"
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
      var worker;
      worker = this;
      this.callback = callback;
      this.enterQueryinPath(query);
      this.requestOptions.path = this.pathParts.base + queryString.stringify(this.pathParts.options);
      return http.get(this.requestOptions, function(response) {
        var text;
        text = "";
        response.on("data", function(data) {
          return text += data;
        });
        return response.on("end", function() {
          var jsonData;
          console.log(text);
          jsonData = eval('(' + text + ')');
          return worker.validateData(jsonData, function(valid, outputData) {
            if (valid === true) {
              return worker.callback(true, outputData);
            } else {
              return worker.callback(false, "");
            }
          });
        });
      });
    };
    Worker.prototype.enterQueryinPath = function(query) {};
    Worker.prototype.validateData = function(jsonData, callback) {};
    Worker.prototype.getOutput = function() {};
    Worker.prototype.formatResult = function(title, content, author, source, url) {
      var result;
      result = {
        title: title,
        content: content,
        author: author,
        source: source,
        url: url
      };
      return result;
    };
    Worker.prototype.applyLimit = function(output) {
      return output.slice(0, this.limit);
    };
    return Worker;
  })();
}).call(this);
