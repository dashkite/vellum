import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"
import Registry from "../src"

do ->

  print await test "vellum", [
    test "no tests defined", -> assert false
  ]
