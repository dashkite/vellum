import { pipe, flow } from "@dashkite/joy/function"
import * as _ from "@dashkite/joy/metaclass"
import * as k from "@dashkite/katana"
import * as c from "@dashkite/carbon"
import Feed from "./resource"
import html from "./html"
import css from "./css"

merge = (data, description) ->
  Object.assign {}, description, data

class extends c.Handle

  _.mixin @, [
    c.tag "vellum-feed"
    c.diff
    c.initialize [
      c.shadow
      c.sheets main: css
      c.activate [
        c.description
        k.push Feed.get
        k.push merge
        c.render html
      ]
    ]
  ]
