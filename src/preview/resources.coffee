import {flow, curry, tee} from "@pandastrike/garden"
import * as m from "@dashkite/mercury"
import s from "@dashkite/mercury-sky"

get = curry (name, object) -> object[name]

get = flow [
  m.use m.Fetch.client mode: "cors"
  s.discover "https://links-api.dashkite.com/"
  s.resource "preview"
  m.from [
    m.data [ "url" ]
    m.parameters
  ]
  s.method "get"
  s.request
  m.json
  get "json"
]

Preview = {get}

export {Preview}
