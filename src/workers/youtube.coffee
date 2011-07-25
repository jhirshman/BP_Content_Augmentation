Yql = require "./yql"

module.exports = class Youtube extends Yql
    
    constructor: (limit) ->
        super true, limit        
        @subjects.all = true
        
        @workerID = "youtube"
        @siteName = "Youtube"
    
    enterQueryinPath: (query) ->      
        @pathParts.options.q =  'select * from youtube.search where query="'+ query + '"'
    
    getOutput: (results) ->
        output = new Array()
        for video in results.video
            output.push {
                title: video.title
                content: video.content
                author: video.author
                source: @siteName
                url: video.url
                workerID: @workerID
                queryText: @queryText
            }
        return @applyLimit output
