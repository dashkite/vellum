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

  scroll: ( handle ) ->
    handle
      .root
      .querySelector "[part='options']"
      .scrollIntoView
        behavior: "smooth"
        block: "end"

  set: ( selected, handle ) ->
    handle.dom.value = selected.dataset.value
    input = handle.root.querySelector "input"
    # input.value = handle.dom.value
    # handle.dispatch "input", handle.dom.value
    handle.dispatch "input", input.value
  
  change: ( selected, handle ) ->
    handle.dom.dataset.state = "closed"
    Options.set selected, handle
    input = handle.root.querySelector "input"
    handle.dispatch "change", input.value

  clear: ( selected, handle ) ->
    handle.dom.dataset.state = "closed"
    handle.dom.value = ""
    input = handle.root.querySelector "input"
    input.value = ""

events = Rio.initialize [
  
  Rio.keyup "input", [
    K.peek ( event, handle ) ->
      switch event.code
        when "ArrowDown"
          Options.scroll handle
          selected = Options.selected handle
          if selected?
            if ( target = selected.nextSibling )?
              selected.classList.remove "selected"
              target.classList.add "selected"
              target.scrollIntoView
                behavior: "smooth"
                block: "end"
              Options.set target, handle
          else if ( selected = Options.first handle )?
            selected.classList.add "selected"
            selected.scrollIntoView
              behavior: "smooth"
              block: "end"
            Options.set selected, handle

        when "ArrowUp"
          selected = Options.selected handle
          if selected?
            if ( target = selected.previousSibling )?
              selected.classList.remove "selected"
              target.classList.add "selected"
              target.scrollIntoView
                behavior: "smooth"
                block: "nearest"
              Options.set target, handle

        when "Escape"
          selected = Options.selected handle
          if selected?
            selected.classList.remove "selected"
            Options.clear handle

        when "Enter"
          selected = Options.selected handle
          if selected?
            selected.classList.remove "selected"
            span = selected.querySelector "span"
            input = handle.root.querySelector "input"
            Options.change selected, handle

        else
          input = handle.root.querySelector "input"
          # handle.dom.value = input.value
          handle.dispatch "search", input.value


  ]
  
  Rio.event "click", [
    K.peek ( event, handle ) ->
      if ( selected = Options.target handle, event )?
        if ( current = Options.selected handle )?
          current.classList.remove "selected"
        selected.classList.add "selected"
        Options.change selected, handle
  ]

  Rio.event "input", [
    Rio.intercept
    K.peek ( event, handle ) ->
      handle.dom.value = event.target.value
  ]

]

export default events