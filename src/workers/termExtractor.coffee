Yql = require "./yql"

module.exports = class TermExtractor extends Yql
    constructor: (limit) ->
        super false, limit
    enterQueryinPath: (query) ->      
        @pathParts.options.q =  'select * from search.termextract where context="'+ query + '"'
    getOutput: (results) ->
        return @applyLimit results.Result
