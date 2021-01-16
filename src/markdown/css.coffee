import {once} from "@pandastrike/garden"
import * as q from "@dashkite/quark"

# TODO how to make this more customizable?
# For font-sizes, one way to set the base scale.
css = q.build q.sheet [

  q.select ":host", [
    q.article [ "all" ]
  ]
]

export default css
