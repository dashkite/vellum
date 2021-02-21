import {curry, tee, flow} from "@pandastrike/garden"
import * as m from "@dashkite/mercury"
import c from "configuration"

get = curry (name, object) -> object[name]

Feed =

  get: ({url}) ->
    do flow [
      m.use m.Fetch.client mode: "cors"
      m.url url
      m.accept "application/xml"
      m.method "get"
      m.request
      m.expect.ok
      m.text
      get "text"
      (xml) ->
        parser = new DOMParser
        feed = parser.parseFromString xml, "text/xml"
        items = (Array.from feed.querySelectorAll "item")
          .map (item) ->
            link = item
              .querySelector "link"
              .textContent
            {link}

        {items}
  ]

export default Feed
