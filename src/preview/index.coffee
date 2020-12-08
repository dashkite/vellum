import {pipe, flow} from "@pandastrike/garden"
import * as k from "@dashkite/katana"
import * as c from "@dashkite/carbon"
import {Preview} from "./resources"
import html from "./html.pug"
import css from "./css"
import {normalize} from "./helpers"

merge = (data, description) ->
  console.log description
  Object.assign {}, description, data

class extends c.Handle

  c.mixin @, [
    c.tag "vellum-preview"
    c.diff
    c.initialize [
      c.shadow
      c.sheet "main", css
      c.activate [
        c.description
        k.push Preview.get
        k.push merge
        normalize
        k.log "data"
        c.render html
      ]
    ]
  ]
