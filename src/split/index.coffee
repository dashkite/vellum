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
      c.event "mousedown", [
        c.matches ".gutter", [
          Ks.poke (event, handle) ->
            handle.drag =
              target: event.target
              left: _left = event.target.previousSibling
              right: event.target.nextSibling
              start: S.parseNumber _left.style.flexGrow
              change: 0
        ]
      ]
      c.event "mousemove", [
        Ks.peek (event, handle) ->
          if handle.drag?
            event.stopPropagation()
            event.preventDefault()
            {target, left, right, start, change} = handle.drag
            change += event.movementX
            lx = start + Math.round ((change / handle.dom.offsetWidth) * 100)
            rx = 100 - left
            left.style.flex = "#{lx} 0 #{lx}%"
            right.style.flexGrow = "#{rx} 0 #{rx}%"
            handle.drag.change = change
      ]
      c.event "mouseup", [
        Ks.peek (event, handle) -> handle.drag = undefined
      ]
] ]
