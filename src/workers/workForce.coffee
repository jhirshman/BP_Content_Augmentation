TermExtractor = require './termExtractor'
Youtube = require './youtube'
WolframMathWorld = require './wolframMathWorld'
HyperPhysics = require './hyperPhysics'
Owl = require './owl'
Wikipedia = require './wikipedia'

module.exports = class WorkForce
    
    workers: {
        youtube: () ->
            return new Youtube(5)
        termExtract: () ->
            return new TermExtractor(2)
        wolframMW: () ->
            return new WolframMathWorld(1)
        hyperPhysics: () ->
            return new HyperPhysics(1)
        owl: () ->
            return new Owl(1)
        wikipedia: () ->
            return new Wikipedia(3)
    }
        
    
    extractTermsAndGetData: (text, subject, action) ->
        me = @
        @extractTerms text, (terms) ->
            me.getData terms, subject, action
        
    extractTerms: (text, callback) ->
        @workers.termExtract().query text, (valid, terms)->
            if valid != "true"
                throw "error with extraction"
            callback terms
    
    getData: (terms, subject="generic", action = (data)-> console.log data) ->
        for term in terms
            for name, worker of @workers
                myWorker = worker()
                if myWorker.subjects[subject] == true || myWorker.subjects.all == true
                    console.log "***"+name+": "+term
                    myWorker.query term, (valid, results) ->
                        if valid == "true"
                            #console.log "valid"
                            for data in results
                                action(data)
                        else
                            console.log valid
