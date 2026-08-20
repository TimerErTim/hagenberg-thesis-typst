#let is-classic = eval(sys.inputs.at("is-classic", default: "false"))

#import "../lib.typ": THESIS_STYLE, WORK_TYPES, full-thesis, titlepage

#set document(
  title: "Thesis Title",
  // Or single string: "Author Name"
  author: ("Author Name", "Name Two", "Name Three"),
  // Keep Short and Simple, no abstract
  description: "Thesis Description",
  // Optional, can be deleted.
  keywords: ("Keyword 1 ", "Keyword 2"),
)
#set text(lang: "en")

#import "../template/abbrev.typ": abbr
#show: full-thesis.with(
  thesis-style: if is-classic { THESIS_STYLE.classic } else {
    THESIS_STYLE.modern
  },
  titlepage: titlepage(
    "Computer Science",
    "Dr. Max Mentorman",
    work-type: WORK_TYPES.bachelor-thesis,
  ),
  acknowledgement: include "../template/chapters/acknowledgement.typ", // Can be deleted if not required
  kurzfassung: include "../template/chapters/kurzfassung.typ",
  abstract: include "../template/chapters/abstract.typ",
  preamble: include "../template/chapters/preamble.typ", // Can be deleted if not required
  appendix: include "../template/chapters/appendix.typ", // Can be deleted if not required
  abbreviations: abbr, // Can be deleted if you don't need abbreviations
  bibl: bibliography("../template/bib.yaml"), // Can be replaced with a BibLaTex file
)

#include "../template/chapters/introduction.typ"
#include "../template/chapters/methodology.typ"
#include "../template/chapters/conclusion.typ"
