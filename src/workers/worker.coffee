queryString = require "querystring"
http = require "http"

module.exports = class Worker

    constructor: (limit = 5) ->
        @requestOptions = {
            host: "",
            port: 80,
            path: "",
            "user-agent": "BenchPrep content augmentation client contact @ chicago@benchprep.com"
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
        
        @callback = callback 
        @enterQueryinPath query 
        
        @requestOptions.path = @pathParts.base + queryString.stringify(@pathParts.options)
        #console.log @requestOptions.path
        
        http.get @requestOptions, (response) ->
            text = "";
            
            response.on "data", (data) ->
                text += data
            
            response.on "end", () ->
                console.log text
                jsonData = eval ('(' + text + ')')
                worker.validateData jsonData, (valid, outputData) ->
                    if valid == true
                        worker.callback true, outputData
                    else
                        worker.callback false, ""

    enterQueryinPath: (query) ->

    validateData: (jsonData, callback) ->

    getOutput: () ->

    formatResult: (title, content, author, source, url) ->
        result = {
            title: title,
            content: content,
            author: author,
            source: source,
            url: url
        }
        
        return result
        
    applyLimit: (output) ->
        return output[ 0...@limit ]
        
