Google = require "./google"

module.exports = class HyperPhysics extends Google
   
    constructor: (limit) ->
        super
        @subjects.science = true
        
        @workerID = "hp"
        @siteName = "HyperPhysics - Georgia State University"
    
    enterQueryinPath: (query) ->      
        @pathParts.options.q =  query + " site:hyperphysics.phy-astr.gsu.edu"
