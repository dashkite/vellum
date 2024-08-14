import * as Rio from "@dashkite/rio"
import * as K from "@dashkite/katana/async"

Options =
  selected: ( handle ) ->
    handle
      .root
      .querySelector "slot[name='option']"
      .assignedNodes()
      .find ( node ) ->
        node.classList?.contains "selected"

  first: ( handle ) ->
    handle
      .root
      .querySelector "slot[name='option']"
      .assignedNodes()
      .at 0

  target: ( handle, event ) ->
    slotted = handle
      .root
      .querySelector "slot[name='option']"
      .assignedNodes()
    event
      .composedPath()
      .find ( el ) -> el in slotted

  set: ( selected, handle ) ->
    handle.dom.dataset.state = "closed"
    handle.dom.value = selected.dataset.value
    handle.dispatch "change", handle.dom.value

events = Rio.initialize [
  
  Rio.keyup "input", [
    K.peek ( event, handle ) ->
      switch event.code
        when "ArrowDown"
          selected = Options.selected handle
          if selected?
            if ( target = selected.nextSibling )?
              selected.classList.remove "selected"
              target.classList.add "selected"
              target.scrollIntoView
                behavior: "smooth"
                block: "nearest"
          else if ( selected = Options.first handle )?
            selected.classList.add "selected"
            selected.scrollIntoView
              behavior: "smooth"
              block: "nearest"

        when "ArrowUp"
          selected = Options.selected handle
          if selected?
            if ( target = selected.previousSibling )?
              selected.classList.remove "selected"
              target.classList.add "selected"
              target.scrollIntoView
                behavior: "smooth"
                block: "nearest"

        when "Escape"
          selected = Options.selected handle
          if selected?
            selected.classList.remove "selected"

        when "Enter"
          selected = Options.selected handle
          if selected?
            selected.classList.remove "selected"
            span = selected.querySelector "span"
            input = handle.root.querySelector "input"
            Options.set selected, handle

  ]
  
  Rio.event "click", [
    K.peek ( event, handle ) ->
      if ( selected = Options.target handle, event )?
        if ( current = Options.selected handle )?
          current.classList.remove "selected"
        selected.classList.add "selected"
        Options.set selected, handle
  ]

]

export default events