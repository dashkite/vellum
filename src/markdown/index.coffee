import * as c from "@dashkite/carbon"
import * as k from "@dashkite/katana"
import marked from "marked"
import css from "./css"

class extends c.Handle

  c.mixin @, [
    c.tag "vellum-markdown"
    c.diff
    c.initialize [
      c.shadow
      c.sheet "main", css
      c.activate [
        k.push ({handle}) ->
          marked (handle
          .dom
          .querySelector "script[type='text/markdown']"
          .innerText)
        c.render (html) -> html
  ] ] ]
