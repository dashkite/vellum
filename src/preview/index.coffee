import Registry from "@dashkite/helium"
import { pipe, flow } from "@dashkite/joy/function"
import * as _ from "@dashkite/joy/metaclass"
import * as k from "@dashkite/katana"
import * as c from "@dashkite/carbon"
import html from "./html"
import css from "./css"
import { normalize } from "./helpers"

merge = (data, description) ->
  Object.assign {}, description, data

class extends c.Handle

  _.mixin @, [
    c.tag "vellum-preview"
    c.diff
    c.initialize [
      c.shadow
      c.sheets main: css
      c.activate [
        k.read "handle"
        c.description
        k.push ({url}, handle) ->
          Registry
          .get "cms"
          .load
            name: "preview"
            parameters: {url}
        k.push merge
        normalize
        c.render html
      ]
    ]
  ]
