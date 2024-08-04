import * as Meta from "@dashkite/joy/metaclass"
import * as K from "@dashkite/katana/async"
import * as Ks from "@dashkite/katana/sync"
import * as Rio from "@dashkite/rio"

# import html from "./html"
# import css from "./css"

class extends Rio.Handle

  Meta.mixin @, [
    Rio.tag "vellum-editor"
    Rio.diff
    Rio.initialize [
      Rio.shadow
      # Rio.sheets [
      #   css
      # ]

      Rio.activate [
        # Rio.render html
        Ks.peek ( handle ) ->
      ]
    ]
  ]