import * as c from "@dashkite/carbon"
import * as k from "@dashkite/katana"
import html from "./html.pug"
import css from "./css"

class extends c.Handle

  c.mixin @, [
    c.tag "vellum-article"
    c.diff
    c.initialize [
      c.shadow
      c.sheet css
      c.activate [
        k.push ({handle}) ->
          json =
            handle
            .dom
            .querySelector "script[type='application/json']"
            .innerText
          JSON.parse json
        c.render html
  ] ] ]
