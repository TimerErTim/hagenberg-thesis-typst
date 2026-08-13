#import "i18n.typ": i18n-date-long
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

= Erklärung

Ich erkläre eidesstattlich, dass ich die vorliegende Arbeit selbstständig und ohne fremde Hilfe verfasst, andere als die angegebenen Quellen nicht benutzt und die den benutzten Quellen entnommenen Stellen als solche gekennzeichnet habe. Die Arbeit wurde bisher in gleicher oder ähnlicher Form keiner anderen Prüfungsbehörde vorgelegt.

#v(1.5cm)
#grid(
  columns: (2fr, 1fr),
  [Datum], [Unterschrift],
)
