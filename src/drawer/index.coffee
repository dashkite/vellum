import * as _ from "@dashkite/joy/metaclass"
import * as c from "@dashkite/carbon"
import * as k from "@dashkite/katana"
import html from "./html"
import css from "./css"

class extends c.Handle

  _.mixin @, [
    c.tag "vellum-drawer"
    c.diff
    c.initialize [
      c.shadow
      c.sheets main: css
      c.activate [
        c.description
        c.render html
  ] ] ]
