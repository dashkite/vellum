# Vellum

*Web Components used in DashKite applications*

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

## Introduction

Presently, this is a somewhat random collection of Web Components based on the needs of our applications. They are also largely experimental and you should probably not try to use them in other applications.

Eventually, we may expand this into a more comprehensive collection.

### Design Approach

The design of Vellum components differ from other Web Component frameworks (namely, Shoelace) in their emphasis on _delegated design_. As much as possible, Vellum relies on specific standard browser interfaces to provide structure and behavior, while delegating presentation details to the client.

### Components

All component element tags have the prefix `vellum-`.

| Component    | Description                                                  | Limitations                                     |
| ------------ | ------------------------------------------------------------ | ----------------------------------------------- |
| field        | Form fields with support for a label, an optional hint, and error message. Various input types are supported, as well as custom inputs. |                                                 |
| autocomplete | An dynamic auto-complete search box. Options are provide via slots and can contain arbitrarily complex DOM. |                                                 |
| splitter     | Multipane splitter with draggable boundaries. Panes can contain arbitrary content. | Currently, only allows horizontal splits.       |
| messages     | Displays messages and accepts a message queue. Various types of messages are support (information, warning, …) and formatted accordingly. | Currently, only supports a single global queue. |
| markdown     | Display markdown provided via script tag in light DOM.       |                                                 |
| tabs         | Displays a set of tab slots and displays the corresponding content slot when it’s selected. |                                                 |

Other components under development:

- text-editor: a WYSIWYG rich text editor
- image-editor: an image editor with support for resizing, filters, and more
- drawer: similar to the native `details` element, but with easier styling

## API

### Field

#### Attributes

- `name`
- `value`
- `type`
- `subtype`
- `required`
- `disabled`
- `placeholder` (not yet supported)

#### Slots

- `label`: the label to display for the given input.
- `hint`: an optional hint explaining the purpose of the field.
- `error`: an optional error message to display for validation.
- `input`: a custom input if none of the built-in types are sufficient.
- `options`: an optional `datalist` or `datalist`-like element.

#### Parts

TBD

#### Lexicon

TBD

### Autocomplete

Slots

- option

### Splitter

TBD

### Messages

TBD

### Markdown

TBD

### Tabs

TBD

