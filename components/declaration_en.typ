#import "i8n.typ": i8n-date-long
#show: it => context {
  set text(font: ("Verdana", "Arial", text.font), size: 10pt)
  it
}
#show heading.where(level: 1): set block(spacing: 2em)
#set page(margin: (
  top: 3cm,
  left: 2.5cm,
  bottom: 2cm,
  right: 2.27cm,
))
= Declaration

I hereby declare and confirm that this thesis is entirely the result of my own original work. Where other sources of information have been used, they have been indicated as such and properly acknowledged. I further declare that this or similar work has not been submitted for credit elsewhere.

#v(1.5cm)
#grid(
  columns: (2fr, 1fr),
  [Date], [Signature],
)
