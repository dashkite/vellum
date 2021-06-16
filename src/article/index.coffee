import * as _ from "@dashkite/joy/metaclass"
import * as c from "@dashkite/carbon"
import * as k from "@dashkite/katana"
import html from "./html"
import css from "./css"
import table from "./table"

scroll = k.peek (_, {handle}) ->
  if window.location.hash != ""
    (handle.root.querySelector window.location.hash)
    .scrollIntoView()

class extends c.Handle

  _.mixin @, [
    c.tag "vellum-article"
    c.diff
    c.initialize [
      c.shadow
      c.sheets
        main: css
        table: table
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
        scroll
  ] ] ]
