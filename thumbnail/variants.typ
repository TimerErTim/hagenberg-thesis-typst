#let should-be-flat = sys.inputs.at("is-flat", default: false) == "true"
#let should-be-classic = sys.inputs.at("is-classic", default: false) == "true"

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

#grid(
  columns: if not should-be-flat { (1fr, 1fr) } else { (1fr, 1fr, 1fr, 1fr) },
  gutter: 1mm,
  stroke: gray,
  fill: white,
  image(path, page: 1),
  image(path, page: 8),
  image(path, page: 9),
  image(path, page: 15),
)
