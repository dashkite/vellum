import {once} from "@pandastrike/garden"
import * as q from "@dashkite/quark"

css = q.build q.sheet [

  q.select ":host", [
    q.display "grid"
    q.set "place-items", "var(--align, center)"
    q.select "article", [
      q.article [ "all", "aside right", "figure right" ]
      q.margin bottom: q.rem 3
    ]
  ]
]

export default css
