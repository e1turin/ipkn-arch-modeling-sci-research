// Presentation Template (Polylux)
//
// A slide deck using the Polylux package.
// Requires: typst compile with internet access to fetch @preview/polylux.
//
// Usage:
//   1. Set the title, subtitle, and author.
//   2. Add slides using #slide[ ... ] blocks.
//   3. Compile: typst compile presentation.typ

#import "@preview/polylux:0.3.3": *

// Set theme (options: clean, simple, metropolis, etc.)
// #show: clean-theme.with()
#show: metropolis-theme.with(
  title: "Presentation Title",
  subtitle: "Subtitle",
  author: "Author Name",
  date: datetime.today(),
)

// ------------------------
// Title Slide
// ------------------------
#title-slide()

// ------------------------
// Outline
// ------------------------
#slide[
  #outline(title: [Outline], depth: 2)
]

// ------------------------
// Content Slides
// ------------------------
#slide(title: "Section Title")[
  #lorem(15)
]

== Subsection Slide

#slide[
  - Key point one
  - Key point two
  - Key point three
]

#slide[
  #lorem(20)

  *Important*: This is highlighted information.
]

// ------------------------
// Code Slide
// ------------------------
#slide(title: "Code Example")[
  ```python
  def hello():
      print("Hello, Typst!")
  ```
]

// ------------------------
// Two-Column Layout
// ------------------------
#slide[
  #columns(2)[
    #lorem(15)

    #lorem(10)
  ]
]

// ------------------------
// Math Slide
// ------------------------
#slide(title: "Key Equation")[
  $ E = m c^2 $

  Where:
  - $E$ is energy
  - $m$ is mass
  - $c$ is the speed of light
]

// ------------------------
// Final Slide
// ------------------------
#slide[
  #align(center + horizon)[
    #text(size: 24pt, weight: "bold")[Thank You]

    #v(12pt)
    Questions?
  ]
]
