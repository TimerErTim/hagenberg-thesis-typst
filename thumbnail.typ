#let should-be-flat = sys.inputs.at("is-flat", default: false) == "true"
#set page(
  paper: "a4",
  height: auto,
  margin: 1em,
  fill: white.transparentize(100%),
)

#grid(
  columns: if not should-be-flat { (1fr, 1fr) } else { (1fr, 1fr, 1fr, 1fr) },
  gutter: 1em,
  stroke: gray,
  image("out/template.pdf", page: 1),
  image("out/template.pdf", page: 8),
  image("out/template.pdf", page: 9),
  image("out/template.pdf", page: 15),
)
