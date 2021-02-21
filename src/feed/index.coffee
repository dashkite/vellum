import {pipe, flow} from "@pandastrike/garden"
import * as k from "@dashkite/katana"
import * as c from "@dashkite/carbon"
import Feed from "./resource"
import html from "./html.pug"
# import css from "./css.styl"

merge = (data, description) ->
  Object.assign {}, description, data

class extends c.Handle

  c.mixin @, [
    c.tag "vellum-feed"
    c.diff
    c.initialize [
      c.shadow
      # c.sheet "main", css
      c.activate [
        c.description
        k.push Feed.get
        k.push merge
        c.render html
      ]
    ]
  ]
