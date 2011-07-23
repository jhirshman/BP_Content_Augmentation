Worker = require "./worker"

module.exports = class Yql extends Worker
    
    constructor: (openTable, limit) ->      
        super limit
        
        @requestOptions.host = "query.yahooapis.com"       
        @pathParts.base = "/v1/public/yql?"       
        @pathParts.options = {
            q: "",
            format: "json",
            diagnostics: "false",
            callback: ""
        }
        
        @pathParts.options.env = "store://datatables.org/alltableswithkeys" unless openTable == false
        
        @workerID = "yql"
        @workerName = "Yahoo Query Language"
        
    validateData: (jsonData, callback) ->
        if !jsonData.query?.count? || jsonData.query.count < 1
            callback false, ""
        
        else
            callback true, @getOutput(jsonData.query.results)

