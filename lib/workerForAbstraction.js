(function() {
  var Specific, http, queryString;
  queryString = require("querystring");
  http = require("http");
  module.exports = Specific = (function() {
    function Specific() {
      this.query = query;
      this.requestOptions = {
        host: "",
        port: 80,
        path: ""
      };
      this.pathParts = {
        base: "",
        options: {}
      };
      this.requestOptions.host = "query.yahooapis.com";
      this.pathParts.base = "/v1/public/yql?";
      this.pathParts.options = {
        q: "",
        format: "json",
        diagnostics: "false",
        callback: ""
      };
    }
    Specific.prototype.query = function(query, callback) {
      var path;
      this.callback = callback;
      this.enterQueryinPath(query);
      path = this.pathParts.base + queryString.stringify(this.pathParts.options);
      return http.get(this.requestOptions, function(response) {
        var text;
        text = "";
        response.on("data", function(data) {
          return text += data;
        });
        return response.on("end", function() {
          var jsonData;
          jsonData = eval('(' + text + ')');
          return this.validateData(jsonData, function(valid, outputData) {
            if (valid === true) {
              return this.callback(true, outputData);
            } else {
              return this.callback(false, "");
            }
          });
        });
      });
    };
    Specific.prototype.enterQueryinPath = function(query) {
      return this.pathParts.options.q = encodeURI('select * from search.termextract where context="#{query}"');
    };
    Specific.prototype.validateData = function(jsonData, callback) {
      var _ref;
      if (!(((_ref = jsonData.query) != null ? _ref.count : void 0) != null) || jsonData.query.count < 1) {
        callback(false, "");
      }
      return callback(true, this.getOutput(jsonData.query.results));
    };
    Specific.prototype.getOutput = function(results) {
      return results.Result;
    };
    return Specific;
  })();
}).call(this);
