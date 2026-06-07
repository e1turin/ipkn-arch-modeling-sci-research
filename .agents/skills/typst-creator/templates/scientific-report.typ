// Scientific Report Template
//
// A clean, general-purpose academic paper template.
// Customize the metadata below and add sections as needed.
//
// Usage:
//   1. Fill in the title, author, date, and abstract.
//   2. Write sections using =, ==, === headings.
//   3. Add a bibliography file and cite with @key.
//   4. Compile: typst compile scientific-report.typ

// ------------------------
// Metadata
// ------------------------
#let doc-title = "Your Paper Title"
#let doc-author = "Author Name"
#let doc-date = datetime.today().display("[month] [day], [year]")

// ------------------------
// Page setup
// ------------------------
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  numbering: "1",
  number-align: center,
)

#set text(
  font: ("Liberation Serif", "Times New Roman"),
  size: 11pt,
  lang: "en",
)

#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.")

// ------------------------
// Title block
// ------------------------
#align(center)[
  #text(size: 18pt, weight: "bold", doc-title)
  #v(4pt)
  #text(size: 10pt, doc-author)
  #v(2pt)
  #text(size: 10pt, doc-date)
]

#line(length: 100%, stroke: 0.5pt)
#v(8pt)

// ------------------------
// Abstract
// ------------------------
#text(weight: "bold", size: 11pt)[Abstract]
#v(4pt)
#rect(
  inset: (x: 10pt, y: 6pt),
  stroke: 0.5pt + gray,
  width: 100%,
)[
  #lorem(20)  // Replace with actual abstract text
]

#v(8pt)
#line(length: 100%, stroke: 0.5pt)
#v(12pt)

// ------------------------
// Table of Contents
// ------------------------
#outline(title: [Contents], depth: 3)
#pagebreak()

// ------------------------
// Sections start here
// ------------------------
= Introduction

#lorem(30)

== Background

#lorem(25)

=== Related Work

#lorem(20)

= Methodology

#lorem(35)

== Data Collection

#lorem(25)

#figure(
  image(/* "figure.png" */),  // Replace with image path
  caption: [Data pipeline overview],
) <fig:pipeline>

== Analysis

#lorem(30)

= Results

#lorem(25)

#figure(
  table(
    columns: 3,
    table.header([*Metric*], [*Control*], [*Experiment*]),
    [Accuracy], [0.82], [0.91],
    [Precision], [0.79], [0.89],
    [Recall], [0.81], [0.92],
  ),
  caption: [Experimental results],
) <tab:results>

= Discussion

#lorem(30)

= Conclusion

#lorem(20)

// ------------------------
// References
// ------------------------
#pagebreak()
#bibliography(/* "references.bib" */, title: [References], style: "ieee")
