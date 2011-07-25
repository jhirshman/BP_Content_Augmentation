fs = require "fs"

module.exports = class FileUtility    

    readFile: (filePath, callback) ->
        
        fs.readFile filePath, (error, data)->
            
            if error
                console.log "Error in file reader"
                throw error
                
            callback data
            
    stripHTML: (text, callback) ->
        
        plainText = String(text).replace /(<([^>]+)>)/ig, ""
        
        callback plainText
        
    readAndStripHTML: (filePath, callback) ->       
        me = @
        @readFile filePath, (data) ->
            me.stripHTML data, (plainText) -> 
                callback plainText
