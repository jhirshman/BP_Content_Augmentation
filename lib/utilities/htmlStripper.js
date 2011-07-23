(function() {
  module.exports = {
    strip: function(text, callback) {
      var plainText;
      plainText = String(text).replace(/(<([^>]+)>)/ig, "");
      return callback(plainText);
    }
  };
}).call(this);
