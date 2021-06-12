import * as _ from "@dashkite/joy/metaclass"
import * as c from "@dashkite/carbon"
import * as k from "@dashkite/katana"
import html from "./html"
import css from "./css"

class extends c.Handle

  _.mixin @, [
    c.tag "vellum-nav"
    c.diff
    c.initialize [
      c.shadow
      c.sheets main: css
      c.activate [
        k.read "handle"
        k.push (handle) ->
          json =
            handle
            .dom
            .querySelector "script[type='application/json']"
            .innerText
          JSON.parse json
        c.render html
  ] ] ]
