import * as c from "@dashkite/carbon"
import * as k from "@dashkite/katana"
import html from "./html.pug"
import css from "./css"
import table from "./table.styl"

class extends c.Handle

  c.mixin @, [
    c.tag "vellum-article"
    c.diff
    c.initialize [
      c.shadow
      c.sheet "main", css
      c.sheet "table", table
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
