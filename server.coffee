express = require("express")
jade = require ("jade")
# rabbitHub = require("rabbitmq-nodejs-client")
context = require("rabbit.js").createContext("amqp://localhost")
# sockjs = require("sockjs")

app = module.exports = express.createServer()
app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + "/public")

app.configure "development", ->
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

app.configure "production", ->
  app.use express.errorHandler()

app.get "/", (req, res) ->
  pub = context.socket("PUB")
  pub.connect "events", ->
    console.log "in the pub callback"
    pub.write JSON.stringify(welcome: "rabbit.js"), "utf8"

  res.render "index",
    title: "node_rr - Node with RabbitMQ"

app.listen 3000
console.log "Express server listening on port %d", app.address().port
