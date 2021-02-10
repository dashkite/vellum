import Registry from "@dashkite/helium"
import {pipe, flow} from "@pandastrike/garden"
import * as k from "@dashkite/katana"
import * as c from "@dashkite/carbon"
import html from "./html.pug"
import css from "./css.styl"
import {normalize} from "./helpers"

merge = (data, description) ->
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
        k.push ({url}, {handle}) ->
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
