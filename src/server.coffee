TermExtractor = require './workers/termExtractor'
Youtube = require './workers/youtube'
WolframMathWorld = require './workers/wolframMathWorld'
HyperPhysics = require './workers/hyperPhysics'
Owl = require './workers/owl'
Wikipedia = require './workers/wikipedia'

workers = {
    youtube: new Youtube(1),
    termExtract: new TermExtractor(1),
    wolframMW: new WolframMathWorld(1),
    hyperPhysics: new HyperPhysics(1),
    owl: new Owl(1)
    wikipedia: new Wikipedia(1)
}

for name, worker of workers
    if name == "wikipedia"
        worker.query "triangles", (valid, output) ->
            if valid
                console.log "valid"
                console.log output
            else
                console.log "invalid"
        
