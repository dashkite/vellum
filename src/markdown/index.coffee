import * as c from "@dashkite/carbon"
import * as k from "@dashkite/katana"
import marked from "marked"
import css from "./css"

demote = (start) ->
  heading: (text, level) ->
    level = Number(start) + Number(level) - 1
    "<h#{level}>#{text}</h#{level}"

class extends c.Handle

  c.mixin @, [
    c.tag "vellum-markdown"
    c.diff
    c.initialize [
      c.shadow
      c.sheet "main", css
      c.activate [
        c.description
        k.push ({startLevel}, {handle}) ->
          marked.use renderer: demote startLevel
          marked (handle
          .dom
          .querySelector "script[type='text/markdown']"
          .innerText)
        c.render (html) -> html
  ] ] ]
