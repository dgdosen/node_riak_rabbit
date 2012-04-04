express = require("express")
db = require("riak-js").getClient(
  host: "127.0.0.1"
  port: "8091"
)
jade = require ("jade")
context = require("rabbit.js").createContext("amqp://localhost")

context.on "ready", ->
  console.log "reading queue"
  sub = context.socket("SUB")
  # sub.pipe process.stdout
  sub.connect "events", ->
    console.log "in the sub callback "
    sub.on "data", (msg) ->
      console.log "reading off queue: " + JSON.parse(msg)['welcome']
      db.save "test", "doc2",
        msg: msg['welcome']
        title: "hello riak and rabbit", ->
          console.log "in the server save callback: not sure how to see data"


