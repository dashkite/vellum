import {flow, curry, tee} from "@pandastrike/garden"
import * as m from "@dashkite/mercury"
import Template from "url-template"

template = Template.parse "https://www.dashkite.com/preview{?url}"

get = curry (name, object) -> object[name]

get = flow [
  m.use m.Fetch.client mode: "cors"
  m.from [
    m.data [ "url" ]
    template.expand
    m.url
  ]
  m.accept "application/json"
  m.method "get"
  m.request
  m.json
  get "json"
]

Preview = {get}

export {Preview}
