import {once} from "@pandastrike/garden"
import * as q from "@dashkite/quark"

css = q.build q.sheet [

  q.select ":host", [
    q.article [ "all" ]
  ]
]

export default css
