import { eventful } from "@dashkite/wayland"
import Options from "./options"

# TODO possibly use event.key instead of event.code

events = ( base ) ->

  class extends eventful base

    @keyup()
      .matches "input"
      .intercept()
      .apply ( event ) ->
        switch event.key
          when "ArrowDown"
            Options.scroll @
            selected = Options.selected @
            if selected?
              if ( target = selected.nextSibling )?
                selected.classList.remove "selected"
                target.classList.add "selected"
                target.scrollIntoView
                  behavior: "smooth"
                  block: "end"
                Options.set target, @
            else if ( selected = Options.first @ )?
              selected.classList.add "selected"
              selected.scrollIntoView
                behavior: "smooth"
                block: "end"
              Options.set selected, @

          when "ArrowUp"
            selected = Options.selected @
            if selected?
              if ( target = selected.previousSibling )?
                selected.classList.remove "selected"
                target.classList.add "selected"
                target.scrollIntoView
                  behavior: "smooth"
                  block: "nearest"
                Options.set target, @

          when "Escape"
            selected = Options.selected @
            if selected?
              selected.classList.remove "selected"
              Options.clear @

          when "Enter"
            selected = Options.selected @
            if selected?
              selected.classList.remove "selected"
              span = selected.querySelector "span"
              input = @root.querySelector "input"
              Options.change selected, @

          else
            input = @root.querySelector "input"
            @dispatch "search", input.value

    @click()
      .intercept()
      .apply ( event ) ->
        if ( selected = Options.target @, event )?
          if ( current = Options.selected @ )?
            current.classList.remove "selected"
          selected.classList.add "selected"
          Options.change selected, @

    @input()
      .intercept()
      .apply ( event ) -> 
        @dom.value = event.target.value

    @focusin()
      .apply ( event ) ->
        if ( Options.list @ ).elements.length > 0
          @dom.dataset.state = "open"
    
    @focusout()
      .matches "input"
      .intercept()
      .apply ( event ) ->
        @dom.dataset.state = "closed"

export default events