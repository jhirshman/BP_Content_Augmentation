mongoose = require 'mongoose'
Schema = mongoose.Schema

ContentSchema = new Schema {
    title: String
    content: String
    author: String
    source: String
    url: String
    workerID: String
    query:String

}


mongoose.connect 'mongodb://localhost/contentData'
mongoose.model 'Content', ContentSchema

Content = mongoose.model 'Content'

exports.clear = () ->
    Content.remove {}, () ->

exports.insertIntoDB = (data) ->
    content = new Content();
    content.title = data.title
    content.content = data.content
    content.author = data.author
    content.source = data.source
    content.url = data.url
    content.workerID = data.workerID
    content.query = data.queryText
    
    content.save (err) ->
        if err
            throw err
        
        #console.log "saved"

exports.printDB = () ->
    Content.find {}, (err, docs) ->
        for doc in docs
            console.log doc.title + " : " + doc.source
            #eyes.inspect doc


