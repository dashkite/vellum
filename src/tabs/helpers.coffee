import Generic from "@dashkite/generic"

Tab = 

  selected: ( root ) ->
    root.querySelector "[slot=tab][selected]"

  select: ( Generic.make "Tab.select" )

    .define [ Element, Element ], ( root, el ) ->
      Tab.deselect root
      el.setAttribute "selected", ""
      Panel.select root
    
    .define [ Element, String ], ( root, selector ) ->
      Tab.select root, root.querySelector selector

  deselect: ( root ) ->
    Tab
      .selected root
      ?.removeAttribute "selected"

Panel =

  selected: ( root ) ->
    root.querySelector "[slot=panel][selected]"

  select: ( root ) ->
    if ( panel = Panel.selected root )?
      panel.removeAttribute "selected"
    { name } = root.querySelector "[slot=tab][selected]"
    root
      .querySelector "[slot=panel][name=#{name}]"
      ?.setAttribute "selected", ""

export { Tab, Panel }