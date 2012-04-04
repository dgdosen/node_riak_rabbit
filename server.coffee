express = require("express")
jade = require ("jade")
db = require("riak-js").getClient(
  host: "127.0.0.1"
  port: "8091"
)
rabbitHub = require("rabbitmq-nodejs-client")
# context = require("rabbit.js").createContext("amqp://localhost")
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

app.get "/mq", (req, res) ->
  console.log "reading queue"
  # rep = context.socket("SUB")
  # rep.connect "events", ->
  #   console.log "connected to events"
  #   rep.setEncoding "utf8"
  #   rep.on "data", (msg) ->
  #     console.log "writing from message on queue: " + msg
  # res.send "thank you"

  # TODO: This works, but it flawed.  It starts listenting when this route is triggered...
  subHub = rabbitHub.create(
    task: "sub"
    channel: "myChannel"
  )
  subHub.on "connection", (hub) ->
    hub.on "message", (msg) ->
      console.log msg

  subHub.connect()


app.get "/", (req, res) ->
  # TODO not ensuring context is ready...
  # pub = context.socket("PUB")
  # sub = context.socket("SUB")
  # sub.pipe process.stdout
  # sub.connect "events", ->
  #   pub.connect "events", ->
  #     pub.write JSON.stringify(welcome: "rabbit.js"), "utf8"

  pubHub = rabbitHub.create(
    task: "pub"
    channel: "myChannel"
  )
  pubHub.on "connection", (hub) ->
    hub.send "Hello Rabbit MQ!"
  pubHub.connect()

  db.save "test", "doc2",
    foo: "hell yeah 9:41 am"
    title: "hello riak", ->
      console.log "in the server save callback"
  db.get "test", "doc2", (err, data) ->
    console.log "found in test json: " + JSON.stringify(data)

  res.render "index",
    title: "node_rr - Node with Riak and RabbitMQ"

app.listen 3000
console.log "Express server listening on port %d", app.address().port
