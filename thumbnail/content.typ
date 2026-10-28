#let is-classic = eval(sys.inputs.at("is-classic", default: "false"))

#import "../lib.typ": (
  LICENSE_TYPES, THESIS_STYLE, WORK_TYPES, copyright-page, full-thesis,
  titlepage, generative-ai-documentation
)

#set document(
  title: "Thesis Title",
  // Or single string: "Author Name"
  author: ("Author Name", "Name Two", "Name Three"),
  // Keep Short and Simple, no abstract
  description: "Thesis Description",
  // Optional, can be deleted.
  keywords: ("Keyword 1 ", "Keyword 2"),
)
#set text(lang: sys.inputs.at("lang", default: "en"))

#import "../template/abbrev.typ": abbr
#show: full-thesis.with(
  thesis-style: if is-classic { THESIS_STYLE.classic } else {
    THESIS_STYLE.modern
  },
  titlepage: {
    titlepage(
      "Computer Science",
      "Dr. Max Mentorman",
      work-type: WORK_TYPES.bachelor-thesis,
    )
    pagebreak()
    copyright-page(LICENSE_TYPES.cc-by-nc-nd)
  },
  acknowledgement: include "../template/chapters/acknowledgement.typ", // Can be deleted if not required
  kurzfassung: include "../template/chapters/kurzfassung.typ",
  abstract: include "../template/chapters/abstract.typ",
  preamble: include "../template/chapters/preamble.typ", // Can be deleted if not required
  appendix: [
    #include "../template/chapters/appendix.typ"

    #generative-ai-documentation(
      verification-confirmed: true,
      responsibility-confirmed: true,
      literature-search-tools-used: [ChatGPT, Elicit],
      literature-search-tool-usage: [Used to discover search terms and summarize candidate papers for the literature review.],
      coding-tools-used: [GitHub Copilot],
      coding-tool-usage: [Used to suggest unit tests and explain errors in the implementation chapter.],
    )
  ],
  abbreviations: abbr, // Can be deleted if you don't need abbreviations
  bibl: bibliography("../template/bib.yaml"), // Can be replaced with a BibLaTex file
)

#include "../template/chapters/introduction.typ"
#include "../template/chapters/methodology.typ"
#include "../template/chapters/conclusion.typ"
