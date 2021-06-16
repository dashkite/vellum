import Registry from "@dashkite/helium"
import { pipe, flow, binary } from "@dashkite/joy/function"
import { merge } from "@dashkite/joy/object"
import { mixin } from "@dashkite/joy/metaclass"
import * as k from "@dashkite/katana"
import * as c from "@dashkite/carbon"
import html from "./html"
import css from "./css"
import { normalize } from "./helpers"

class extends c.Handle

  mixin @, [
    c.tag "vellum-preview"
    c.diff
    c.initialize [
      c.shadow
      c.sheets main: css
      c.activate [
        k.read "handle"
        c.description
        k.push -> Registry.get "cms"
        k.poke (cms, {url}, handle) ->
          cms.load
            name: "preview"
            parameters: {url}
        k.push binary merge
        normalize
        c.render html
      ]
    ]
  ]
