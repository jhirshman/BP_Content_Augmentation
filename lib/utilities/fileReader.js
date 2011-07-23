(function() {
  var fs;
  fs = require("fs");
  module.exports = {
    read: function(cwd, filePath, callback) {
      var path;
      path = this.cwd + '/' + filePath;
      return fs.readFile(path, function(error, data) {
        if (error) {
          console.log("Error in html stripper");
          throw error;
        }
        return callback(data);
      });
    }
  };
}).call(this);
