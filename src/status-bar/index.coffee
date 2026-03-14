import * as Fn from "@dashkite/joy/function"
import { shadowed, renderable, styleable } from "@dashkite/wayland"

import html from "./html"
import css from "./css"

class extends do Fn.pipe [ shadowed, renderable, styleable ]

  @tag "status-bar"

  @sheets [ css ]

  @connect -> @render html()
