import * as F from "@dashkite/joy/function"
import * as A from "@dashkite/joy/array"
import * as O from "@dashkite/joy/object"
import * as T from "@dashkite/joy/type"
import * as S from "@dashkite/joy/text"
import * as I from "@dashkite/joy/iterable"
import * as K from "@dashkite/katana"
import * as Ks from "@dashkite/katana/sync"


_mutate = F.curry (handler, handle) ->
  _handler = -> handler { handle }
  observer = new MutationObserver _handler
  observer.observe handle.dom, subtree: true, childList: true, attributes: true

mutate = (fx) -> K.peek _mutate F.flow fx

mutate._ = _mutate

getKey = F.pipe [
  (el) -> el.getAttribute("slot")
  S.split "-"
  A.rest
  I.join "-"
]

getKeys = F.flow [
  K.read "handle"
  K.poke F.pipe [
    (handle) -> handle.dom.querySelectorAll "[slot^=tab-]"
    I.map getKey
    I.collect
  ]
  K.poke (keys) -> { keys }
]

getSelected = F.flow [
  K.read "handle"
  K.poke (handle) -> handle.dom.querySelector "[selected]"
  K.test T.isDefined, F.flow [
    K.poke getKey
    K.poke (selected) -> { selected }
  ]
]

getContext = F.flow [
  getKeys
  getSelected
  K.mpoke F.binary O.merge
]

select = Ks.peek (el) -> el.setAttribute "selected", true

reveal = F.pipe [
  Ks.poke (el) -> el.dataset.key
  Ks.push (key, event, handle) ->
    handle.root.querySelector "section[data-key='#{key}']"
  Ks.pop (el) -> el.setAttribute "aria-hidden", "false"
]

deselect = F.pipe [
  Ks.push (el, event, handle) ->
    handle.root.querySelectorAll "button[selected]"
  Ks.pop I.each (el) -> el.removeAttribute "selected"
]

hide = F.pipe [
  Ks.push (el, event, handle) ->
    handle.root.querySelectorAll "[aria-hidden='false']"
  Ks.pop I.each (el) -> el.setAttribute "aria-hidden", "true"
]

export {
  mutate
  getContext
  select
  reveal
  deselect
  hide
}
