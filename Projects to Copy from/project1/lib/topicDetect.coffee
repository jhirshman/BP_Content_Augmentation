http = require "http"
query = require "querystring"

exports.getTopics = (text, func) ->

    urlBase = "/ContentAnalysisService/V1/termExtraction?"

    params = {
        appid: encodeURI("3uZXHx7V34EAIAAFB7H.0OV85YjCpAfwTWHf258YTW0h_NCPWb2FfsnxBGiR268LY1NL1Xy58lVYzPrAY3X7"),
        context: text,
        output: "json"
    }

    url = urlBase + query.stringify(params)

    options = {
        host: "search.yahooapis.com",
        port: 80,
        path: url,
        method: "POST"
    }

    req = http.request options, (res) ->
        result = ""
        res.on 'data', (data) ->
            result += data
        
        res.on 'end', () ->
            formatArray result, func
            
    req.end()

formatArray = (result, func) ->
    results = eval '('+result + ')'
    resultArray = results.ResultSet.Result
    
    func (resultArray)
    
