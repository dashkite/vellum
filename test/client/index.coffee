import assert from "@dashkite/assert"
import { test } from "@dashkite/amen"

import Registry from "@dashkite/helium"
import "@dashkite/vellum"

import fixtures from "./fixtures"

Registry.set
  cms:
    load: ({name, parameters}) -> fixtures[name][parameters.url]

do ->

  window.__test = await do ->

    test "In-Browser Tests", []
