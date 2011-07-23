queryString = require "querystring"
http = require "http"

module.exports = class Specific
    
    constructor: () ->      
        #worker
        @query = query       
        @requestOptions = {
            host: "",
            port: 80,
            path: ""            
        }       
        @pathParts = {
            base: "",
            options: {}
        }
        #yahoo
        @requestOptions.host = "query.yahooapis.com"       
        @pathParts.base = "/v1/public/yql?"       
        @pathParts.options = {
            q: "",
            format: "json",
            diagnostics: "false",
            callback: ""
        }      
        #Termextraction   
    
    #worker
    query: (query, callback) ->   
        @callback = callback     
        @enterQueryinPath query       
        path = @pathParts.base + queryString.stringify(@pathParts.options)
        
        http.get @requestOptions, (response) ->
            text = "";
            response.on "data", (data) ->
                text += data
            response.on "end", () ->
                jsonData = eval ('(' + text + ')')
                @validateData jsonData, (valid, outputData) ->
                    if valid == true
                        @callback true, outputData
                    else
                        @callback false, ""
    
    #Termextraction
    enterQueryinPath: (query) ->        
        @pathParts.options.q =  encodeURI 'select * from search.termextract where context="#{query}"'
    
    #Yahoo
    validateData: (jsonData, callback) ->
        if !jsonData.query?.count? || jsonData.query.count < 1
            callback false, ""
        
        callback true, @getOutput(jsonData.query.results)
    
    #Termextraction
    getOutput: (results) ->
        return results.Result
    
        
       
