fs = require "fs"

module.exports =     

    read: (cwd, filePath, callback) ->
        
        path = @cwd + '/' + filePath
        
        fs.readFile path, (error, data)->
            
            if error
                console.log "Error in html stripper"
                throw error
                
            callback data
