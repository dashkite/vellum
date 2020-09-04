import {once} from "@pandastrike/garden"
import * as q from "@dashkite/quark"

css = q.build q.sheet [

  q.select ":host", [
    q.rows
    q.set "align-items", "center"
    q.padding q.hrem 2
  ]

  q.select "h1", [
    q.reset [ "block" ]
    q.type "small heading"
  ]
]

export default css
