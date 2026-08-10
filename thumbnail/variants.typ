#let should-be-flat = sys.inputs.at("is-flat", default: "false") == "true"
#let should-be-classic = sys.inputs.at("is-classic", default: "false") == "true"

#set page(
  paper: "a4",
  height: auto,
  margin: 0pt,
  fill: white.transparentize(100%),
)
#let path = {
  "../out/template"
  if should-be-classic {
    "_classic"
  } else {
    "_modern"
  }
  ".pdf"
}

#let pages = if should-be-classic { (7, 8, 13, 14) } else { (7, 9, 15, 16) }

#grid(
  columns: if not should-be-flat { (1fr, 1fr) } else { (1fr, 1fr, 1fr, 1fr) },
  gutter: 1mm,
  stroke: gray,
  fill: white,
  ..pages.map(page => image(path, page: page)),
)
