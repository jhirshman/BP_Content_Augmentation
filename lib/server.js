(function() {
  var Database, FileUtility, WorkForce, filePath, fileUtility, workForce;
  Database = require('./utilities/database');
  FileUtility = require('./utilities/fileUtility');
  WorkForce = require('./workers/workForce');
  Database.clear();
  workForce = new WorkForce;
  fileUtility = new FileUtility;
  filePath = __dirname + "/testHTML.html";
  fileUtility.readAndStripHTML(filePath, function(text) {
    return workForce.getData(["mitochondria"], "science", function(data) {
      return Database.insertIntoDB(data);
    });
  });
}).call(this);
