(function() {
  var Content, ContentSchema, Schema, mongoose;
  mongoose = require('mongoose');
  Schema = mongoose.Schema;
  ContentSchema = new Schema({
    title: String,
    content: String,
    author: String,
    source: String,
    url: String,
    workerID: String,
    query: String
  });
  mongoose.connect('mongodb://localhost/contentData');
  mongoose.model('Content', ContentSchema);
  Content = mongoose.model('Content');
  exports.clear = function() {
    return Content.remove({}, function() {});
  };
  exports.insertIntoDB = function(data) {
    var content;
    content = new Content();
    content.title = data.title;
    content.content = data.content;
    content.author = data.author;
    content.source = data.source;
    content.url = data.url;
    content.workerID = data.workerID;
    content.query = data.queryText;
    return content.save(function(err) {
      if (err) {
        throw err;
      }
    });
  };
  exports.printDB = function() {
    return Content.find({}, function(err, docs) {
      var doc, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = docs.length; _i < _len; _i++) {
        doc = docs[_i];
        _results.push(console.log(doc.title + " : " + doc.source));
      }
      return _results;
    });
  };
}).call(this);
