import assert from "assert"
import {print, test, success} from "amen"
import Registry from "../src"

do ->

  print await test "vellum", [
    test "no tests defined", -> assert false
  ]
