fScript = require "../lib/fileScript.js"
topicDetect = require "../lib/topicDetect.coffee"

data = fScript.getFileContents "testFile.html", (data) ->
        
        
        plainText = String(data).replace /(<([^>]+)>)/ig, ""
        
        
        topicDetect.getTopics plainText, (topics)->
                console.log topics
