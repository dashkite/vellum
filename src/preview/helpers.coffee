import {pipe, curry, tee} from "@pandastrike/garden"
import {toLower, merge} from "panda-parchment"
import * as k from "@dashkite/katana"
import DOMPurify from "dompurify"
import dayjs from "dayjs"

date = (timestamp) ->
  dayjs timestamp
  .format "MMM DD, YYYY"

truncate = (length, suffix, string) ->
  if string.length <= length
    string
  else
    (string.substr 0, string.lastIndexOf " ", length) + suffix

extractMedia = (data) ->
  data.image = data.media?.images?[0]?.formats?[0]?.url ? null
  data

transforms =
  default: (data) ->
    extractMedia data

  twitter: (data) ->
    data.title = "Twitter"
    data

  # TODO: First image is not an image, though we need to confirm in future.
  gfycat: (data) ->
    data.image = data.media?.images?[1]?.formats?[0]?.url ? null
    delete data.author
    delete data.description
    data.layout = "image"
    data

  reddit: (data) ->
    data = extractMedia data
    [author, title] = data.title.split " - "
    delete data.description
    merge data, {author, title}

  instagram: (data) ->
    data = extractMedia data
    data.title = data.description ? "Instagram"
    data
    # if title?
    #   description = data.title.replace(/^[^:]+:[ ]/, "").slice 1, -1
    #   title = data.title.replace /on.*$/, ""
    # merge data, {title, description}

  # Don't include description for tumblr b/c it's a bio,
  # not a description of the content and may include HTML
  tumblr: (data) ->
    data = extractMedia data
    delete data.description
    data

  pinterest: (data) ->
    data = extractMedia data
    delete data.description
    delete data.title
    data.layout = "image"
    data

  imgur: (data) ->
    data = extractMedia data
    # data.description = data.title
    # delete data.title
    delete data.description
    delete data.author if data.author == data.publisher
    data

  giphy: (data) ->
    data = extractMedia data
    data.title = "Giphy"
    delete data.description
    delete data.author if data.author == data.publisher
    delete data.published
    data

  "wikimedia foundation, inc.": (data) ->
    # if there's only one image, it's their logo
    if data.media?.images? and data.media.images.length > 1
      data.image = data.media.images[0].formats[0].url

    if ! (data.url.match /wikipedia.org/)?
      return data

    publisher = "Wikipedia"
    [_, title] = data.title.match /(.*) - Wikipedia$/

    delete data.author

    merge data, {title, publisher}


normalize = k.poke (data) ->
  data.publisher = data.publisher?.trim()
  publisher = toLower data.publisher ? "default"
  if data.published?
    data.published = date data.published
  transform = transforms[publisher] ? transforms.default
  if data.description
    data.description = truncate 200, "&hellip;", DOMPurify.sanitize data.description
  transform data

export {normalize}
