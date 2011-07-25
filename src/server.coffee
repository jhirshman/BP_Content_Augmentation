TermExtractor = require './workers/termExtractor'
Youtube = require './workers/youtube'
WolframMathWorld = require './workers/wolframMathWorld'
HyperPhysics = require './workers/hyperPhysics'
Owl = require './workers/owl'
Wikipedia = require './workers/wikipedia'
Database = require './utilities/database'
FileUtility = require './utilities/fileUtility'

Database.clear()

workers = {
    youtube: () ->
        return new Youtube(1)
    termExtract: () ->
        return new TermExtractor(2)
    wolframMW: () ->
        return new WolframMathWorld(1)
    hyperPhysics: () ->
        return new HyperPhysics(1)
    owl: () ->
        return new Owl(1)
    wikipedia: () ->
        return new Wikipedia(1)
}

if true
    fileUtility = new FileUtility
    filePath = __dirname+"/testHTML.html"
    fileUtility.readAndStripHTML filePath, (text) ->
        workers.termExtract().query text, (valid, output) ->
            if valid != "true"
                throw "error with extraction"
            for term in output
                for name, worker of workers
                    myWorker = worker()
                    if myWorker.subjects.science == true || myWorker.subjects.all == true
                        console.log "***"+name+": "+term
                        myWorker.query term, (valid, results) ->
                            if valid == "true"
                                #console.log "valid"
                                for data in results
                                    Database.insertIntoDB(data)
                            else
                                console.log valid

