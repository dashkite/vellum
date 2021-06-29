import * as M from "@dashkite/joy/metaclass"
import * as F from "@dashkite/joy/function"
import * as T from "@dashkite/joy/type"
import * as I from "@dashkite/joy/iterable"
import * as S from "@dashkite/joy/text"
import * as c from "@dashkite/carbon"
import * as k from "@dashkite/katana"
import * as Ks from "@dashkite/katana/sync"
import html from "./html"
import css from "./css"

pct = (x) -> Math.round x * 100
num = (x) -> S.parseNumber S.replace /[^\d\.]/g, "", x
val = (p, el) -> (getComputedStyle el)[p]
spct = (x) -> "#{x}%"

class extends c.Handle

  M.mixin @, [
    c.tag "vellum-split"
    c.diff
    c.initialize [
      c.shadow
      c.sheets main: css
      c.activate [
        k.read "handle"
        k.push (handle) ->
          for child, i in handle.dom.children
            if child.slot == ""
              child.slot = "pane-#{i}"
            else
              child.slot
        k.poke (panes, handle) ->
          {panes, sizes: JSON.parse handle.dom.dataset.sizes}
        c.render html
      ]
      c.describe [
        k.read "handle"
        Ks.peek (handle, description) ->
          sizes = JSON.parse description.sizes
          panes = handle.dom.querySelectorAll ".pane"
          for pane, i in panes
            pane.style.flexBasis = spct sizes[i]
      ]
      c.event "mousedown", [
        c.matches ".gutter", [
          Ks.poke (event, handle) ->
            parent = event.target.parentNode
            previous = event.target.previousSibling
            next = event.target.nextSibling
            direction = (getComputedStyle parent).flexDirection
            dimension = if direction == "row" then "width" else "height"
            sizes =
              previous: num val dimension, previous
              next: num val dimension, next
            available = sizes.previous + sizes.next
            start = pct (sizes.previous / available)
            handle.drag = { direction, previous, next, start, change: 0 }
        ]
      ]
      c.event "mousemove", [
        Ks.peek (event, handle) ->
          if handle.drag?
            event.stopPropagation()
            event.preventDefault()
            { direction, previous, next, start, change } = handle.drag
            available = if direction == "row"
              handle.dom.offsetWidth
            else
              handle.dom.offsetHeight
            change += event.movementX
            current = start + (pct (change / available))
            previous.style.flexBasis = spct current
            next.style.flexBasis = spct (100 - current)
            handle.drag.change = change
      ]
      c.event "mouseup", [
        Ks.push (event, handle) -> handle.drag?
        Ks.test T.isDefined, F.pipe [
          Ks.discard
          Ks.push (event, handle) ->
            if handle.drag?
              { previous, next } = handle.drag
              handle.drag = undefined
              handle.dom.dataset.sizes = JSON.stringify [
                num previous.style.flexBasis
                num next.style.flexBasis
              ]
          c.dispatch "change"
] ] ] ]
