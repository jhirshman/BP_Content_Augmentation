
exports.getFileContents = function (filePath, callback) {
    var fs = require("fs");
    var cwd = __dirname
    var path = filePath;

    //console.log(cwd+'/'+path);

    fs.readFile(cwd+'/'+ path, function (err, data) {
        if (err) {
            console.log("error: " + err);
            throw err;
        }
        //console.log("data " + data);
        callback(data)
    });
}

