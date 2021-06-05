import * as t from "@dashkite/genie"
import preset from "@dashkite/genie-presets"
import * as m from "@dashkite/masonry"
import { pug } from "@dashkite/masonry/pug"
import { stylus } from "@dashkite/masonry/stylus"
import { text } from "@dashkite/masonry/text"

preset t

t.define "pug", m.start [
  m.glob "{src,test}/**/*.pug", "."
  m.read
  m.tr pug.compile
  m.extension ".js"
  m.write "build/browser"
]

t.define "stylus", m.start [
  m.glob "{src,test}/**/*.styl", "."
  m.read
  m.tr [ stylus, text ]
  m.extension ".js"
  m.write "build/browser"
]

t.after "build", [ "pug", "stylus" ]
