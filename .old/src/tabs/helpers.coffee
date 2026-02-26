import Generic from "@dashkite/generic"

Tab = 

  selected: ( handle ) ->
    handle.dom.querySelector "[slot=tab][selected]"

  select: ( Generic.make "Tab.select" )

    .define [ Object, Element ], ( handle, el ) ->
      Tab.deselect handle
      el.setAttribute "selected", ""
      Panel.select handle
      handle.dispatch "select", el

    .define [ Object, String ], ( handle, selector ) ->
      Tab.select handle, handle.dom.querySelector selector

  deselect: ( handle ) ->
    Tab
      .selected handle
      ?.removeAttribute "selected"

Panel =

  selected: ( handle ) ->
    handle.dom.querySelector "[slot=panel][selected]"

  select: ( handle ) ->
    Panel.deselect handle
    if ( tab = Tab.selected handle )?
      handle
        .dom
        .querySelector "[slot=panel][name=#{ tab.name }]"
        ?.setAttribute "selected", ""
  
  deselect: ( handle ) ->
    Panel
      .selected handle
      ?.removeAttribute "selected"

export { Tab, Panel }