import {pipeWith, pipe} from "@pandastrike/garden"
import * as q from "@dashkite/quark"

presets = pipeWith q.lookup

  slack: pipe [
    q.plain
    q.sans
    q.set "line-height", q.hrem 2.75
    q.set "font-size", q.hrem 1.9
  ]

export {presets}
