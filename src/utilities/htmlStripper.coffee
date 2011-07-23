
module.exports = 

    strip: (text, callback) ->
        
        plainText = String(text).replace /(<([^>]+)>)/ig, ""
        
        
        callback plainText
