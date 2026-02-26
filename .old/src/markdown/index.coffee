import * as _ from "@dashkite/joy/metaclass"
import * as c from "@dashkite/rio"
import * as k from "@dashkite/katana"
import { Remarkable } from "remarkable"
import css from "./css"

md = new Remarkable

demote = (start) ->
  heading: (text, level) ->
    level = Number(start) + Number(level) - 1
    "<h#{level}>#{text}</h#{level}"

class extends c.Handle

  _.mixin @, [
    c.tag "vellum-markdown"
    c.diff
    c.initialize [
      c.shadow
      c.sheets main: css
      c.activate [
        k.read "handle"
        c.description
        k.push ({startLevel}, handle) ->
          md.render (handle
          .dom
          .querySelector "script[type='text/markdown']"
          .innerText)
        c.render (html) -> html
  ] ] ]
