import express from "express"
import { test, success } from "@dashkite/amen"
import print from "@dashkite/amen-console"
import { sleep } from "@dashkite/joy/time"
import { pipe } from "@dashkite/joy/function"
import * as K from "@dashkite/katana"
import Mimic from "@dashkite/mimic"

app = express()
app.use express.static "./build/browser"

server = app.listen 0
{ port } = server.address()

start = pipe [
  Mimic.browser
  Mimic.context
  Mimic.page
  Mimic.console Mimic.report.console
  Mimic.error Mimic.report.error
  Mimic.goto "http://localhost:#{port}/test/client/index.html"
  Mimic.waitFor ( -> window.__test? ), timeout: 5000
  Mimic.evaluate -> window.__test
]

finish = pipe [
  K.down
  Mimic.close
]

do ->

  # Just give the server a moment to start
  await sleep 500

  results = null
  stack = null

  try
    stack = await start()
    [ rest..., results ] = stack
  catch error
    console.error error
  finally
    if stack?
      await finish stack
    server.close()

  if results?
    print await test "Vellum Lookbook", [ results ]

  process.exit if success then 0 else 1
