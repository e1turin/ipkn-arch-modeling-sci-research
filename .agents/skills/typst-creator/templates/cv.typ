// CV / Resume Template
//
// A clean, professional two-column curriculum vitae.
// Customize the personal info, experience, education, and skills.
//
// Usage:
//   1. Fill in your name, contact, and sections.
//   2. Compile: typst compile cv.typ

// ------------------------
// Page Setup
// ------------------------
#set page(
  paper: "a4",
  margin: (x: 2cm, y: 2cm),
)

#set text(font: ("Helvetica", "Arial"), size: 10pt)
#set par(leading: 0.4em)

// ------------------------
// Colors
// ------------------------
#let accent = rgb("#2c3e50")
#let muted = rgb("#7f8c8d")
#let divider = rgb("#bdc3c7")

// ------------------------
// Helper functions
// ------------------------
#let section(title, body) = {
  v(6pt)
  text(size: 11pt, weight: "bold", fill: accent, title)
  line(length: 100%, stroke: 0.5pt + divider)
  v(4pt)
  body
}

#let entry(title, subtitle, dates, body) = {
  grid(
    columns: (1fr, auto),
    [
      text(weight: "bold", title)
      text(size: 9pt, fill: muted, subtitle)
    ],
    text(size: 9pt, fill: muted, dates)[
      #align(right)[
        #text(size: 9pt, fill: muted, dates)
      ]
    ],
  )
  v(2pt)
  body
  v(4pt)
}

#let skill-category(category, items) = {
  text(weight: "bold", size: 9pt, category)
  text(size: 9pt, items)
  v(4pt)
}

// ------------------------
// Header
// ------------------------
#align(center)[
  #text(size: 22pt, weight: "bold", fill: accent)[John Doe]
  #v(4pt)
  #text(size: 9pt, fill: muted)[
    john.doe@example.com \ (+1) 555-0123 \ linkedin.com/in/johndoe \ github.com/johndoe
  ]
]
#v(8pt)

// ------------------------
// Professional Summary
// ------------------------
#section([Professional Summary], [
  #lorem(25)
])

// ------------------------
// Experience
// ------------------------
#section([Experience], [

  #entry(
    "Senior Engineer",
    "Company Name, City",
    "2020 -- Present",
    [
      - Led a team of 5 engineers delivering $lorem(5)
      - Achieved $lorem(8)
    ],
  )

  #entry(
    "Software Developer",
    "Previous Company, City",
    "2017 -- 2020",
    [
      - Developed $lorem(6)
      - Improved $lorem(5)
    ],
  )

  #entry(
    "Junior Developer",
    "Earlier Company, City",
    "2015 -- 2017",
    [
      - Assisted in $lorem(6)
    ],
  )
])

// ------------------------
// Education
// ------------------------
#section([Education], [

  #entry(
    "Master of Science in Computer Science",
    "University Name, City",
    "2013 -- 2015",
    [
      - Thesis: $lorem(6)
      - GPA: 3.8 / 4.0
    ],
  )

  #entry(
    "Bachelor of Science in Computer Science",
    "University Name, City",
    "2009 -- 2013",
    [
      - Dean's List, Honors program
    ],
  )
])

// ------------------------
// Skills
// ------------------------
#section([Skills], [

  #skill-category("Languages:", "Python, TypeScript, Rust, Go")
  #skill-category("Frameworks:", "React, PyTorch, FastAPI, Actix")
  #skill-category("Tools:", "Docker, Kubernetes, Git, Linux")
  #skill-category("Languages (spoken):", "English (native), Spanish (fluent)")
])

// ------------------------
// Projects
// ------------------------
#section([Projects], [

  #entry(
    "Open Source Project",
    "github.com/username/project",
    "2022",
    [#lorem(10)],
  )

  #entry(
    "Research Tool",
    "github.com/username/tool",
    "2021",
    [#lorem(10)],
  )
])
