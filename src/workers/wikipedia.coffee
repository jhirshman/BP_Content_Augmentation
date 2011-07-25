Worker = require "./worker"

module.exports = class Wikipedia extends Worker
    
    constructor: (limit) ->   
        super limit
        
        @requestOptions.host = "en.wikipedia.org"       
        @pathParts.base = "/w/api.php?"       
        @pathParts.options = {
            action: "opensearch"
            search: ""
            format: "json"
            limit: limit
        }
        
        @workerID = "wikipedia"
        @siteName = "Wikipedia.org"
        
        @subjects.all = true
        
    enterQueryinPath: (query) ->      
        @pathParts.options.search =  query
    
    getOutput: (results) ->
        output = new Array()
        for result in results
            output.push {
                title: result
                #content: 
                author: @siteName
                source: @siteName
                url: "en.wikipedia.org/wiki/" + result
                workerID: @workerID
                queryText: @queryText
            }
        return @applyLimit output
    
    validateData: (jsonData, callback) ->
        if !jsonData[1]?
            callback "errorWithJSONObject", ""
        else if jsonData[1].length < 1
            callback "no results", ""      
        else
            callback "true", @getOutput(jsonData[1])
