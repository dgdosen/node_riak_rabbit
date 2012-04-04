express = require("express")
jade = require ("jade")
context = require("rabbit.js").createContext("amqp://localhost")

context.on "ready", ->
  console.log "reading queue"
  sub = context.socket("SUB")
  # sub.pipe process.stdout
  sub.connect "events", ->
    console.log "in the sub callback"
    sub.on "data", (msg) ->
      console.log "reading off queue" + msg

