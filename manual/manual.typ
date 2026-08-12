#import "../lib.typ": THESIS_STYLE, abbreviations-section, full-thesis

#set document(
  title: "Thesis Template Manual",
  author: "Tim Peko (TimerErTim)",
  description: "Customization & Usage manual for the \"easy-hgb-thesis\" Campus Hagenberg thesis template",
  keywords: (
    "Typst",
    "Thesis",
    "FH Hagenberg",
    "Template",
    "Manual",
    "Usage",
  ),
)
#set text(lang: "en")

#show: full-thesis.with(
  titlepage: none,
  thesis-style: THESIS_STYLE.modern,
  include-declaration: false,
  kurzfassung: none,
  abstract: none,
  content-style: it => {
    show link: underline
    show link: set text(fill: color.blue)
    it
  },
)
#import "@preview/pinit:0.2.2": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": codly-languages
#import "@preview/oxifmt:1.0.0": strfmt

#show: codly-init.with()
#codly(
  languages: codly-languages,
  lang-format: (name, icon, color) => {
    box(stroke: color, fill: color.lighten(80%), height: 1.2em, radius: 1mm)[
      #box(inset: 2pt, icon)#name
    ]
  },
  number-align: horizon + right,
  skip-line: align(center, sym.dots.h),
  skip-number: [#sym.dots.v],
  smart-skip: true,
)

= Setup

I personally recommend following @quick-start for most seamless setup. You can always fall back to the manual setup in @manual-setup below.

== Prerequisites

You only need a *Typst* compiler, with different options for installation:

- #link("https://typst.app/open-source/#download")[Typst CLI]
- #link("https://typst.app/")[Typst Web App] (for easy collaboration with others)
- #link("https://github.com/Myriad-Dreamin/tinymist")[Tinymist LSP] (personal recommendation)
  - one-click install extension for VSCode based editors
  - manual integration with any other LSP supporting editors

== Quick start <quick-start>

To start with a fresh, pre-configured project, either run the following command in your terminal, assuming you have the CLI installed:

```sh
typst init @preview/easy-hgb-thesis
```

Or sign-in to the *Typst Web App*, navigate to the #link("https://typst.app/universe/package/easy-hgb-thesis")[easy-hgb-thesis Template on Typst Universe], and click *"Create Project in app"*.

== Manual installation <manual-setup>

#let package-metadata = toml("../typst.toml")
#let my-email = (
  package-metadata.package.authors.at(0).find(regex("(?:<|@)([^>]+)")).slice(1)
)

First import the template package:

#raw(
  strfmt(
    ```typ
    #import "@preview/easy-hgb-thesis:{version}": full-thesis, titlepage, WORK_TYPES
    ```.text,
    version: package-metadata.package.version,
  ),
  lang: "typ",
  block: true,
)

Then set the document metadata:

```typ
#set document(
  title: "Your Thesis Title",
  description: "A short description of your thesis",
  author: "Your Name",
  keywords: ("Keyword 1", "Keyword 2"),
)
```

Finally, wrap the document in the full-thesis template:

#codly(skips: ((16, 3),))
```typ
#show: full-thesis.with(
  titlepage: titlepage(
    "Computer Science",  // Course of study
    "Dr. Max Mentorman", // Mentor name
    work-type: WORK_TYPES.bachelor-thesis,
  ),
  kurzfassung: include "chapters/kurzfassung.typ",
  abstract: include "chapters/abstract.typ",
  bibl: bibliography("bib.yaml"), // Can be replaced with a BibLaTex file,
)

= Chapter 1

This document will explain...

```

The document is now ready to be compiled and can be customized according to your needs. Refer to @customization for more information.

== Compilation

I recommend using the `typst compile` command of the offical *Typst CLI* binary to compile the document or tools listed in @mise-en-place. This will produce a PDF file.

```sh
typst compile main.typ Your_Thesis.pdf
```

If you want to conform to specific PDF standards, you can specify the standard with the `--pdf-standard` flag.

```sh
typst compile main.typ Your_Thesis.pdf --pdf-standard a-3u --format pdf
```

For a list of available standards and their specifications, refer to the #link("https://typst.app/docs/reference/pdf/")[official Typst documentation].

Alternatively, you can download a compiled PDF from the *Typst Web App*.

= Customization <customization>

The template is well documented with inline comments and docstrings. Quick exploration should reveal most customization options. An important concept are style hooks, discussed further down below in @style-hooks.

== Common Options

=== Language support

The template supports *English (`en`)* and *German (`de`)*:
#codly(skips: ((3, 3),))
```typ
#set text(lang: "de")
#show: full-thesis.with(
)
```

=== Document metadata

*Title*, *description*, *authors*, and *keywords* can be customized via a `set`-rule on `document`.

#codly(skips: ((8, 4),))
```typ
#set document(
  title: "Computer Science",
  description: "A thesis on the topic of computer science",
  keywords: ("computer science", "thesis"),
  author: ("Main Author", "Co Author"),
)
#show: full-thesis.with(
)
```

This information is embedded in the metadata of the compiled PDF. It is also picked up by the provided `titlepage` function.

=== Titlepage

The titlepage is customizable via the `titlepage` template parameter. The template simply prepends the titlepage to the document while applying `global-style` (without `document-style`).

#codly(skips: ((8, 3),))
```typ
#show: full-thesis.with(
  titlepage: titlepage(
    "Computer Science",
    "2026/2027",
    "Dr. Max Mentorman",
    work-type: "bachelor-thesis",
  ),
)
```

Omitting the titlepage is as simple as passing *`none`*:
#codly(skips: ((3, 3),))
```typ
#show: full-thesis.with(
  titlepage: none,
)
```
=== Citation style


Depending on your needs, your mentor and field of work, you might need to change the citation style. Luckily, _Typst_ supports pretty much all citation styles out of the box. When providing the `bibliography` template parameter, also add your desired citation style: #cite(<src_lodish-molecular-cell-biology>)

#codly(skips: ((3, 3),))
```typ
#show: full-thesis.with(
  bibliography: bibliography("bib.yaml", style: "ieee"),
)
```
#bibliography("manual.yaml", title: none, style: "ieee")

And switching to *APA*#footnote[Default citation style]: #cite(<src_lodish-molecular-cell-biology>)
#codly(skips: ((3, 3),))
```typ
#show: full-thesis.with(
  bibliography: bibliography("bib.yaml", style: "apa"),
)
```
#bibliography("manual.yaml", title: none, style: "apa")

=== Changing document font

Many users might want to change the font from the default base style. For this, you can use the `document-style` style hook:

#codly(skips: ((6, 3),))
```typ
#show: full-thesis.with(
  document-style: it => {
    set text(font: "Times New Roman", size: 12pt)
    it
  },
)
```

#{
  set text(font: "Times New Roman", size: 12pt)
  set heading(outlined: false)
  [
    ==== Which will apply this font
    To everything inside the document, even tables...
    #show: figure.with(outlined: false, caption: [Font in table demonstration])
    #table(
      columns: 2,
      table.header[*Header 1*][*Header 2*],
      [Cool], [Cool Too],
    )
  ]
}

=== Abbreviation table

An abbreviation table is simply a Typst `dictionary` where the keys are the abbreviations and the values are the full definitions.

#let abbreviations = (
  "USB": "Universal Serial Bus",
  "RAM": "Random Access Memory",
  "MSE": "Mean Squared Error",
)
```typ
#let abbreviations = (
  "USB": "Universal Serial Bus",
  "RAM": "Random Access Memory",
  "MSE": "Mean Squared Error",
)
```

Then pass it to the `abbreviations` template parameter:

#codly(skips: ((3, 3),))
```typ
#show: full-thesis.with(
  abbreviations: abbreviations,
)
```

#{
  show heading: none
  abbreviations-section(
    abbreviations,
  )
}

=== Change thesis style

The template supports two different thesis styles, which control the overall look and feel of the document: *classic* and *modern*. The classic style is the default and is more traditional. It tries to loyal to the #link("https://github.com/Digital-Media/HagenbergThesis/tree/main")[Digital-Media/HagenbergThesis] template, whereas the modern style is clean, uniform and inspired by higher technical college diploma thesis design guides. To change the thesis style, you can use the `thesis-style` template parameter:

#codly(skips: ((3, 3),))
```typ
#show: full-thesis.with(
  thesis-style: THESIS_STYLE.modern,
)
```

You can try out the different styles even after finishing your thesis (assuming no major style modifications were made by you)! Feedback to the *modern* style is especially helpful!

=== Two-column layout

_Typst_ easily supports two-column layouts out of the box. Make use of the `content-style` style hook to achieve this:

#codly(skips: ((2, 3),))
```typ
#show: full-thesis.with(
  content-style: it => {
    set page(columns: 2)
    it
  },
)
```

=== Print size control box

To include a print size control box at the end of the document, which is useful when printing the document on paper but is deactivated by default for digital export, set the `include-print-size-control` template parameter to `true`:

#codly(skips: ((3, 3),))
```typ
#show: full-thesis.with(
  include-print-size-control: true,
)
```

== Style hooks <style-hooks>

Import `full-thesis`, then customize appearance and structure by passing style hooks to `full-thesis.with(...)`, such as:

- `global-style` (fonts, page layout)
- `document-style` (overall document)
- `content-style` (main chapters)
- Section hooks: `abstract-style`, `outline-style`, `bibliography-style`, etc.

These parameters expect functions taking the section content and returning newly styled content. For example changing the page numbering of the main content to roman numerals:

#codly(skips: ((2, 3),))
```typ
#show: full-thesis.with(
  content-style: it => {
    set page(numbering: "I")
    it
  },
)
```

Defaults match typical FH thesis requirements. Override only what you need.

== Sections

Most sections are optional and many can be opt-out of. Simply omitting them from the `full-thesis.with(...)` call will omit them from the document. Sections requiring explicit opt-out are specified with a `none` value:

#codly(skips: ((3, 3),))
```typ
#show: full-thesis.with(
  abstract: none,
)
```

== Advanced

For power users seeking fine-grained control over the document structure, the template provides individual sections as ready to use elements.

These take the section's main content as input and display a correctly stylized version of it. This allows you to put the preamble after the table of contents:

```typ
#show: full-thesis.with(
  preamble-style: _ => {
    // Replace preamble with outline
    chapter-outline()
  },
  outline-style: _ => {
    // Vice-versa
    preample-section[
      This is my preamble, which is now before the table of contents.
    ]
  }
)
```

However, by default the preamble's headings are not listed in the outline. To fix this, you can use the `style-preface` parameter:

```typ
#show: full-thesis.with(
  preamble-style: _ => {
    // Replace preamble with outline
    chapter-outline()
  },
  outline-style: _ => {
    // Vice-versa
    preample-section(style-preface: it => {
      set heading(outlined: true)
      it
    })[
      This is my preamble, which is now before the table of contents.
    ]
  }
)
```

= Third Party Tools

== Hayagriva

#link("https://github.com/typst/hayagriva")[Hayagriva] is Typst's custom bibliography tool and specification. It uses the `.yaml` format, creating a unified data model supporting over *2600* citation styles. It is the recommended way to handle citations in Typst and easy to learn, so I recommend giving it a try if you're fresh to scientific writing. You can find the documentation at #link("https://github.com/typst/hayagriva/blob/main/docs/file-format.md").

Alternatively, Typst also supports BibLaTex files out of the box, so you can use your existing collection with the `bibliography` element.

== Typstyle

#link("https://github.com/typstyle-rs/typstyle")[Typstyle] is a tool for formatting Typst code. It is my personal recommendation so you don't have to worry about formatting your source code. The documentation is available at #link("https://typstyle-rs.github.io/typstyle/").

== mise-en-place <mise-en-place>

#link("https://github.com/jdx/mise")[mise] is a developer environment manager, covering tools, environment variables, tasks, and more. It unifies many setups and makes new projects easy to manage. Check it out here: #link("https://mise.jdx.dev/")

While being 100% optional, for people wanting to work with mise, the quick-start approach in @quick-start contains a mise configuration file, which gets you going quickly. Simply executing `mise run export` will compile the document and produce a PDF file, with no manual installation of the Typst CLI or other tools required.

== Packages


You will find a list of my personal recommended and useful third party Typst packages below. If you need anything not listed here, feel free to browse through #link("https://typst.app/universe/search/?kind=packages")[Typst Universe], which provides a solution for almost any problem.

#let package-recommend(
  name,
  link-value,
  description,
) = [
  + #link(link-value)[#name] - #description
]

#package-recommend(
  "zero",
  "https://typst.app/universe/package/zero",
)[configurable scientific number formatting; basically a requirement for scientific writing]
#package-recommend(
  "cetz",
  "https://typst.app/universe/package/cetz",
  "semi-low-level drawing library, very powerful; often foundation for other drawing packages",
)
#package-recommend(
  "fletcher",
  "https://typst.app/universe/package/fletcher",
)[diagrams with nodes and arrows, powerful; easier but not as flexible as cetz]
#package-recommend(
  "lilaq",
  "https://typst.app/universe/package/lilaq",
)[easy to use plotting library with sane defaults and lots of customization options]
#package-recommend(
  "codly",
  "https://typst.app/universe/package/codly",
)[code-block styling and formatting, has some quite powerful features, used in this manual]
#package-recommend(
  "suiji",
  "https://typst.app/universe/package/suiji",
)[pseudo-random number generator, useful for programmatic generation of data, solves Typst's guarantee of reproducibility and inherent statelessness]

== Support

If you require any assistance, are unsure about approaching certain problems, or just want to chat about Typst, feel free to reach out on GitHub, create an issue #link(package-metadata.package.repository + "/issues")[in the repository], or send me an email at #link("mailto:" + my-email).
