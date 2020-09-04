import * as c from "@dashkite/carbon"
import html from "./html.pug"
import css from "./css"
import themes from "./themes"

class extends c.Handle

  c.mixin @, [
    c.tag "vellum-article"
    c.diff
    c.initialize [
      c.shadow
      c.activate [
        c.render html
  ] ] ]
