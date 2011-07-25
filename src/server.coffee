Database = require './utilities/database'
FileUtility = require './utilities/fileUtility'
WorkForce = require './workers/workForce'

Database.clear()
workForce = new WorkForce
fileUtility = new FileUtility
filePath = __dirname+"/testHTML.html"

fileUtility.readAndStripHTML filePath, (text) ->  
    workForce.getData ["mitochondria"], "science", (data) -> Database.insertIntoDB(data)


