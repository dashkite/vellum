import {once} from "@pandastrike/garden"
import * as q from "@dashkite/quark"

css = q.build q.sheet [

  q.select ":host", [
    q.select "article", [
      q.article [ "all" ]
      q.margin bottom: q.hrem 6
    ]
  ]

]

export default css
