#import "styles.typ" as default-styles
#import "i8n.typ": i8n, i8n-declaration-page
#import "titlepage.typ": titlepage
#import "sections.typ": *

/// Wraps the document in the full-thesis template. This includes a title page and various other sections common in theses.
/// You must have configured the document data in the main document (title, author, description, keywords) before using this template. E.g. ```typ
/// #set document(
///   title: "Thesis Title",
///   author: "Author Name",
///   description: "Thesis Description",
///   keywords: ("Keyword 1 ", "Keyword 2"),  // Optional, only used in PDF Metadata
/// )
/// ```
///
/// You may find yourself needing to configure some styles to your liking. This can be done by passing an appropiate styling function for the acording section. Example - Styling the table header in the abbreviations section to be gray:
/// ```typ
/// #show: full-thesis.with(
///   ...
///   abbreviations-style: it => {
///     set table(fill: (x, y) => if y == 0 { gray })
///     it
///   }
/// )
/// ```
/// The styles cover the following sections:
/// - global-style: Style global settings like fonts, page margins, language, etc.
/// - document-style: Style the entire text document (same as global-style apart title page)
/// - content-style: Style the main content of the document. That is everthing after applying the template `#show: full-thesis.with(...)`
/// - others: The other styles covern their respective sections and are further documented as parameters.
///
/// For more advanced usecases, you can also clone the template repository from #link("https://github.com/timerertim/hagenberg-thesis-template", "GitHub") and adjust it as needed for your project requirements.
///
///
/// - include-tableoutline (auto, true, false): `auto` includes a table outline if there is at least one table in the document,`true` forces to display an outline and `false` deactivates entirely.
/// - include-figureoutline (auto, true, false): `auto` includes a figure outline if there is at least one figure in the document,`true` forces to display an outline and `false` deactivates entirely.
/// - include-declaration (true, false): `true` includes a declaration page, `false` deactivates entirely.
///
/// - global-style (): Style global settings like fonts, page margins, language, etc.
/// - document-style (): Style the entire text document (same as global-style apart title page)
/// - declaration-style (): Style for the declaration page.
/// - acknowledgement-style (): Style for the acknowledgement section.
/// - abstract-style (): Style for the abstract section. Will also be applied to the kurzfassung section (to ensure consistency).
/// - preamble-style (): Style for the preamble section.
/// - outline-style (): Style for all outline sections. Will be applied to chapter, table and figure outlines.
/// - abbreviations-style (): Style for the abbreviations section.
/// - content-style (): Style the main content of the document. That is everthing after applying the template `#show: full-thesis.with(...)`
/// - bibliography-style (): Style for the bibliography section.
/// - appendix-style (): Style for the appendix section.
///
/// - abbreviations (dict): List of abbreviations to display in the abbreviations section. Form (\<abbreviation>: \<description-content>). Example: (`(AI: "Artificial Intelligence")`). If empty, no abbreviations section is displayed.
/// - bibl (content): The bibliography to display. Citation style can be manually overriden here: `#bibliography("...", style: "ieee")`
#let full-thesis(
  // Sections with content
  titlepage: titlepage(
    "Computer Science",
    "2026/2027",
    "Dr. Max Mentorman",
    work-type: "bachelor-thesis",
  ),
  acknowledgement: none,
  abstract: [],
  kurzfassung: [],
  appendix: none,
  preamble: none,

  // Feature toggles
  include-tableoutline: auto,
  include-figureoutline: auto,
  include-declaration: true,

  // Styles
  global-style: it => it,
  document-style: it => it,
  declaration-style: it => it,
  acknowledgement-style: it => it,
  abstract-style: it => it,
  preamble-style: it => it,
  outline-style: it => it,
  abbreviations-style: it => it,
  content-style: it => it,
  bibliography-style: it => it,
  appendix-style: it => it,

  // Abbreviations
  abbreviations: (:),

  // Bibliography
  bibl: none,

  doc,
) = {
  // Define global styles that exist everywhere in the document (like fonts, page size, etc.)
  show: default-styles.global-style
  show: global-style
  // Show titlepage
  if titlepage != none {
    titlepage-section(titlepage)
    pagebreak()
  }

  // Setup document-wide styles that cover normal text content (everything apart title page)
  show: default-styles.document-style
  show: document-style

  // Show declaration page with styles applied
  if include-declaration {
    declaration-page(style-preface: declaration-style)
    pagebreak()
  }

  // Show acknowledgement section with styles applied if applicable
  if acknowledgement != none {
    acknowledgement-section(
      acknowledgement,
      style-preface: acknowledgement-style,
    )
    pagebreak()
  }

  // Show kurzfassung section with styles applied
  if kurzfassung != none {
    kurzfassung-section(kurzfassung, style-preface: abstract-style)
    pagebreak()
  }

  // Show abstract section with styles applied
  if abstract != none {
    abstract-section(abstract, style-preface: abstract-style)
    pagebreak()
  }

  // Show preamble section with styles applied if applicable
  if preamble != none {
    preamble-section(preamble, style-preface: preamble-style)
    pagebreak()
  }

  // Show chapter outline with styles applied
  chapter-outline(style-preface: outline-style)
  pagebreak()

  // Show abbreviations section with styles applied if applicable
  if abbreviations.len() >= 1 {
    abbreviations-section(abbreviations, style-preface: abbreviations-style)
    pagebreak()
  }

  // Show content with styles applied
  {
    show: default-styles.content-style
    show: content-style
    doc
  }

  // Show figure outline with styles applied if applicable (forced or if there is at least one non-table figure)
  context if (
    include-figureoutline == true
      or (
        include-figureoutline == auto
          and query(figure.where(outlined: true)).len() - query(figure.where(kind: table, outlined: true)).len() >= 1
      )
  ) {
    pagebreak()
    figure-outline(style-preface: outline-style)
  }

  // Show table outline with styles applied if applicable (forced or if there is at least one table)
  context if (
    include-tableoutline == true
      or (
        include-tableoutline == auto
          and query(figure.where(kind: table, outlined: true)).len() >= 1
      )
  ) {
    pagebreak()
    table-outline(style-preface: outline-style)
  }

  // Show bibliography section with styles applied
  if bibl != none {
    pagebreak()
    bibliography-section(bibl, style-preface: bibliography-style)
  }

  // Show appendix section with styles applied if applicable
  if appendix != none {
    pagebreak()
    appendix-section(appendix, style-preface: appendix-style)
  }
}
