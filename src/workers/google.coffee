Worker = require "./worker"

module.exports = class Google extends Worker
    
    constructor: (limit) ->   
        super
        
        @requestOptions.host = "ajax.googleapis.com"       
        @pathParts.base = "/ajax/services/search/web?"       
        @pathParts.options = {
            v: "1.0",
            q: ""
        }
        
        @workerID = "google"
        @siteName = "Google"
        
    enterQueryinPath: (query) ->      
        @pathParts.options.q =  query
    
    getOutput: (results) ->
        output = new Array()
        for result in results
            output.push {
                title: result.titleNoFormatting
                content: result.content
                author: @siteName
                source: @siteName
                url: result.url
                workerID: @workerID
            }   
        return @applyLimit output
    
    validateData: (jsonData, callback) ->
        if !jsonData.responseData?.results? || jsonData.responseData.results < 1
            callback false, ""
        
        else
            callback true, @getOutput(jsonData.responseData.results)
