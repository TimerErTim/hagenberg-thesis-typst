#import "i8n.typ": i8n-date-long
#show: it => context {
  set text(font: ("Verdana", "Arial", text.font), size: 10pt)
  it
}
#show heading.where(level: 1): set block(spacing: 2em)
= Erklärung

Ich erkläre eidesstattlich, dass ich die vorliegende Arbeit selbstständig und ohne fremde Hilfe verfasst, andere als die angegebenen Quellen nicht benutzt und die den benutzten Quellen entnommenen Stellen als solche gekennzeichnet habe. Die Arbeit wurde bisher in gleicher oder ähnlicher Form keiner anderen Prüfungsbehörde vorgelegt.

#v(1.5cm)
#grid(
  columns: (2fr, 1fr),
  [Datum],
  [Unterschrift]
)
