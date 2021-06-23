import * as M from "@dashkite/joy/metaclass"
import * as F from "@dashkite/joy/function"
import * as T from "@dashkite/joy/type"
import * as I from "@dashkite/joy/iterable"
import * as c from "@dashkite/carbon"
import * as k from "@dashkite/katana"
import * as ks from "@dashkite/katana/sync"
import html from "./html"
import css from "./css"

querySlot = (name) ->
  F.pipe [
    (handle) ->
      handle
        .shadow
        .querySelector "slot[name='#{name}']"
        .assignedNodes flatten: true
    I.select (el) -> el.nodeType == Node.ELEMENT_NODE
    (list) -> list.entries()
    I.map ([, el]) -> el
  ]

contains = (selector, fx) ->
  F.pipe [
    ks.push (event) -> event.composedPath().find (el) -> el.matches? selector
    ks.test T.isDefined, F.pipe fx
  ]

class extends c.Handle

  M.mixin @, [
    c.tag "vellum-tabs"
    c.diff
    c.initialize [
      c.shadow
      c.sheets main: css
      c.activate [
        c.description
        c.render html
        k.read "handle"
        k.push querySlot "label"
        k.pop I.each (el) ->
          el.setAttribute "role", "tabpanel"
          el.setAttribute "tabindex", "0"
        k.push querySlot "content"
        k.pop I.each (el) ->
          el.setAttribute "aria-hidden", true
        F.pipe [
          ks.push (handle) ->
            handle.dom.querySelector "[slot='label'][selected]"
          ks.test T.isDefined, F.pipe [
            ks.poke (selected) -> selected.dataset.key
            ks.poke (key, handle) ->
              handle.dom.querySelector "[slot='content'][data-key='#{key}']"
            ks.pop (selected) -> selected.setAttribute("aria-hidden", "false")
          ]
        ]
        # for some reason this is null when there are no slotted children
        # possibly because the code above fails
        k.peek (x) -> console.log {x}
        c.event "click", [
          contains "[slot='label']", [
            # deselect tab
            ks.push (el, event, handle) ->
              handle.dom
                .querySelectorAll "[slot='label'][selected]"
            ks.pop I.each (el) -> el.removeAttribute "selected"
            # hide content
            ks.push (el, event, handle) ->
              handle.dom
                .querySelectorAll "[slot='content'][aria-hidden='false']"
            ks.pop I.each (el) -> el.setAttribute "aria-hidden", "true"
            # select tab
            ks.peek (el) -> el.setAttribute "selected", true
            # reveal conent
            ks.poke (el) -> el.dataset.key
            ks.poke (key, event, handle) ->
              handle.dom.querySelector "[slot='content'][data-key='#{key}']"
            ks.peek (el) -> el.setAttribute "aria-hidden", "false"
          ]


        ]

] ] ]
