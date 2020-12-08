import {once} from "@pandastrike/garden"
import * as q from "@dashkite/quark"
import * as b from "./quarks"

css = q.build q.sheet [

  q.select ":host([data-preset='card'])", [

    q.select "article", [
      q.padding q.rem 1
      q.borders [ "round", "silver" ]
      q.article [ "all", "aside right" ]

      q.select "header", [
        q.rows
        q.set "align-items", "flex-start"
        q.padding bottom: q.important q.qrem 1
        q.borders [ "bottom", "silver" ]
        q.margin bottom: q.important q.hrem 1

        q.select ".publisher", [
          q.rows
          q.set "align-items", "center"

          q.select "img", [
            q.reset [ "block" ]
            q.width q.rem 2
            q.margin right: q.hrem 1
          ]

          # q.select "p", [
          #   q.reset [ "block" ]
          #   q.type "extra small heading"
          #   q.text (q.qrem 4), 0.9
          #   q.margin
          #     bottom: q.important 0
          #     right: q.rem 1
          # ]
        ]

        q.select ".headline", [
          q.columns
          q.margin bottom: q.hrem 1
          q.select "h2", [
            q.margin bottom: q.important q.qrem 1
            q.border "none"
            q.text (q.qrem 5), 0.9
          ]
          q.select ".byline", [
            q.rows
            q.set "align-items", "center"
            q.select "p", [
              q.reset [ "block" ]
              q.type "small copy"
              q.text (q.qrem 4), 0.85
              q.margin
                bottom: q.important 0
                right: q.rem 1

              q.select "span.author", [
                q.display "inline-block"
                q.bold
                q.margin right: q.hrem 1
                # TODO why isn't this showing up?
                q.select "&::before", [
                  q.set "content", "by "
                ]
              ] ] ] ] ]

      q.select "section", [

        q.overflow "auto"

        q.select "p", [
          q.type "copy"
          q.text (q.qrem 6), 2/3
          q.margin bottom: q.important q.qrem 4
        ]

        q.select "aside", [
          q.border "none"
          q.select "img", [
            q.width "100%"
            q.set "object-fit", "contain"
          ]
        ]

      ]
    ]
  ]

  q.select ":host([data-preset='slack'])", [
  ]
]

export default css
