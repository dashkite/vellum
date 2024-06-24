import * as Meta from "@dashkite/joy/metaclass"
import * as F from "@dashkite/joy/function"
import * as Type from "@dashkite/joy/type"
import * as I from "@dashkite/joy/iterable"
import * as Text from "@dashkite/joy/text"
import * as R from "@dashkite/rio"
import * as Posh from "@dashkite/posh"
import * as K from "@dashkite/katana/async"
import * as Ks from "@dashkite/katana/sync"
import html from "./html"
import css from "./css"

pct = (x) -> Math.round x * 100
num = (x) -> Text.parseNumber Text.replace /[^\d\.]/g, "", x
computed = (p, el) -> (getComputedStyle el)[p]
spct = (x) -> "#{x}%"
apply = ({ node, size }, change ) ->
  node.style.flexBasis = spct size + change
isDragging = ( event, handle ) -> handle.drag?


class extends R.Handle

  Meta.mixin @, [
    R.tag "vellum-splitter"
    R.diff
    R.initialize [
      R.shadow
      R.sheets [ css ]
      R.mutate [
        K.read "handle"
        K.push (handle) ->
          for child, i in handle.dom.children
            if child.slot == ""
              child.slot = "pane-#{i}"
            else
              child.slot
        K.poke ( panes, handle ) ->
          {panes, sizes: JSON.parse handle.dom.dataset.sizes}
        R.render html
      ]
      R.event "pointerdown", [
        R.matches ".gutter", [
          Ks.poke ( event, handle ) ->
            event.stopPropagation()
            event.preventDefault()
            target = event.target
            target.setPointerCapture event.pointerId
            parent = target.parentNode
            previous = target.previousSibling
            next =  target.nextSibling
            handle.drag =
              target: target
              previous:
                node: previous
                size: num previous.style.flexBasis
              next: 
                node: next
                size: num next.style.flexBasis
              movement: 0
              # TODO compute this based on direction
              available: num computed "width", parent
        ]
      ]
      R.event "pointermove", [
        K.test isDragging, F.pipe [
          R.intercept
          Ks.peek ( event, handle ) ->
            { previous, next, movement, available } = handle.drag
            # TODO compute this based on direction
            movement += event.movementX
            handle.drag.movement = movement
            change = pct ( movement / available )
            if ( previous.size + change  ) >= 0
              if ( next.size - change ) >= 0
                apply previous, change
                apply next, -change
        ]
      ]
      R.event "pointerup", [
        Ks.test (( event, handle ) -> handle.drag? ), F.pipe [
          R.intercept
          Ks.push (event, handle) ->
            { target } = handle.drag
            handle.drag = undefined
            target.releasePointerCapture event.pointerId
            panes = handle
              .root
              .querySelectorAll ".pane"
            sizes = ( num pane.style.flexBasis for pane in panes )
            handle.dom.dataset.sizes = JSON.stringify sizes
                
          R.dispatch "change"
] ] ] ]
