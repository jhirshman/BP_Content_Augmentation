queryString = require "querystring"
http = require "http"

module.exports = class Worker

    constructor: (limit = 5) ->
        @requestOptions = {
            host: "",
            port: 80,
            path: "",
            headers: {"user-agent": "BenchPrep content augmentation client contact @ chicago@benchprep.com"}

        }
        @pathParts = {
            base: "",
            options: {}
        }
        @subjects = {
            math: false
            science: false
            english: false
            writing: false
            all: false
        }
        @limit = limit
        
        @workerID = "worker"
        @workerName = "Worker"
        
     
    query: (query, callback) ->
        worker = @
        @queryText = query
        @callback = callback
        
        @enterQueryinPath query
        
        @requestOptions.path = @pathParts.base + queryString.stringify(@pathParts.options)
        req = http.get @requestOptions, (response) ->
            text = "";
            
            response.on "data", (data) ->
                text += data
            
            response.on "end", () ->
                
                try
                    jsonData = eval ('(' + text + ')')
                
                catch e
                    worker.callback "not valid JSON", ""
                
                worker.validateData jsonData, (valid, outputData) ->
                    worker.valid = valid
                    worker.output = outputData
                    if valid == "true" 
                        worker.callback "true", outputData
                    else
                        worker.callback valid, ""
        
    enterQueryinPath: () ->
        return @queryText

    validateData: (jsonData, callback) ->

    getOutput: () ->
        
    applyLimit: (output) ->
        if @limit < 1
            return output[0...1]
        return output[ 0...@limit ]
        
