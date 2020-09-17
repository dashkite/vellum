import * as c from "@dashkite/carbon"
import * as k from "@dashkite/katana"
import html from "./html.pug"
import css from "./css.styl"

class extends c.Handle

  c.mixin @, [
    c.tag "vellum-nav"
    c.diff
    c.initialize [
      c.shadow
      c.sheet "main", css
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
