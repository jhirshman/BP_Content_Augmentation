Google = require "./google"

module.exports = class WolframMathWorld extends Google
    
    constructor: (limit) ->
        super
        @subjects.math = true
        
        @workerID = "wmw"
        @siteName = "Wolfram MathWorld"
    
    enterQueryinPath: (query) ->      
        @pathParts.options.q =  query + " site:mathworld.wolfram.com"
