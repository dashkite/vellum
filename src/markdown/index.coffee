import * as _ from "@dashkite/joy/metaclass"
import * as c from "@dashkite/carbon"
import * as k from "@dashkite/katana"
import { Remarkable } from "remarkable"
import css from "./css"

md = new Remarkable

# TODO demote headings to appropriate level
#      figure out how to hook into remarkable's parser
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
          # TODO this is a singleton so we should probably
          #      restore the default renderer afterwards
          # TODO why is the ol element not rendering
          md.render (handle
          .dom
          .querySelector "script[type='text/markdown']"
          .innerText)
        c.render (html) -> html
  ] ] ]
