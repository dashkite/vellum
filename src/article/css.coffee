import {once} from "@pandastrike/garden"
import * as q from "@dashkite/quark"

css = q.build q.sheet [

  q.select ":host", [
    q.display "grid"
    q.set "place-items", "var(--justify, center)"
    q.select "article", [
      q.article [ "all" ]
      q.margin bottom: q.hrem 6
    ]
  ]
]

export default css
