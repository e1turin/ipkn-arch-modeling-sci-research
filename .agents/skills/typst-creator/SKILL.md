---
name: typst-creator
description: Write, format, style, script, and compile Typst markup documents — papers, reports, slides, CVs, math, and diagrams. Full reference for syntax, layout, scripting, math, tables, bibliographies, packages, and CLI.
---

# Typst Creator Skill

Use this skill whenever the user asks to create, edit, format, compile, or troubleshoot **Typst** (`.typ`) files. This skill provides an exhaustive reference so you can produce idiomatic, correct, and well-structured Typst documents without guesswork.

---

## When to Use

- Writing or modifying any `.typ` file.
- Creating academic papers, scientific reports (including GOST-compliant), slide decks, CVs, posters, or notebooks.
- Typesetting mathematical equations or matrices.
- Building complex tables with spanning cells, headers, and custom strokes.
- Setting up bibliographies using Hayagriva (`.yaml`) or BibLaTeX (`.bib`) files.
- Creating diagrams with CeTZ, Fletcher, or other packages.
- Compiling, watching, or debugging a Typst project via the CLI.
- Translating LaTeX documents to Typst.

---

## Core Principles

1. **Prefer semantic markup over manual positioning.** Use headings (`=`, `==`), lists (`-`, `+`), and emphasis (`*bold*`, `_italic_`) rather than manual spacing or boxes.
2. **Style globally with `set` and `show` rules.** Keep presentation separate from content. Place `#set` and `#show` rules at the top of the file.
3. **Use packages for common tasks.** CeTZ for drawings, Fletcher for diagrams, Polylux for slides — don't reinvent the wheel.
4. **Always verify with `typst compile`.** After writing or editing, compile to PDF to catch errors.
5. **Separate concerns.** Keep templates, bibliography files (`.bib`/`.yaml`), and content in distinct files. Use `#import` and `#include` to compose them.

---

## Mode Switching

Typst has three syntactical modes. Know how to switch between them:

| New mode | Syntax | Example |
|----------|--------|---------|
| Code | Prefix with `#` | `Number: #(1 + 2)` |
| Math | Surround with `$..$` | `$-x$ is the opposite of $x$` |
| Markup | Surround with `[..]` | `#let name = [*Typst!*]` |

Once in code mode (after `#`), you don't need further hashes until you return to markup or math mode.

---

## Markup Reference

| Element | Syntax | Equivalent function |
|---------|--------|-------------------|
| Paragraph break | Blank line | `parbreak` |
| Strong emphasis | `*strong*` | `strong` |
| Emphasis | `_emphasis_` | `emph` |
| Raw text/code | `` `code` `` or ``` ``` ``` | `raw` |
| Link | `https://example.com/` | `link` |
| Label | `<intro>` | `label` |
| Reference | `@intro` | `ref` |
| Heading | `= Heading`, `== Subheading`, `=== Subsubheading` | `heading` |
| Bullet list | `- item` | `list` |
| Numbered list | `+ item` | `enum` |
| Term list | `/ Term: description` | `terms` |
| Math (inline) | `$x^2$` | `math.equation` |
| Math (block) | `$ x^2 $` (with surrounding spaces) | `math.equation` |
| Line break | `\` | `linebreak` |
| Smart quotes | `'single'` or `"double"` | `smartquote` |
| Non-breaking space | `~` | — |
| Em-dash | `---` | symbol |
| En-dash | `--` | symbol |
| Code expression | `#rect(width: 1cm)` | Scripting |
| Escape char | `\$` (backslash before special char) | — |
| Escape Unicode | `\u{1f600}` | — |
| Comment (single) | `// comment` | — |
| Comment (block) | `/* comment */` | — |

### Comments

```
// This is a single-line comment.
/* This is a
   multi-line comment. */
```

---

## Identifiers & Paths

### Identifiers
- May contain letters, numbers, hyphens (`-`), and underscores (`_`).
- Must start with a letter or underscore.
- Recommended style: **kebab-case** for multi-word identifiers.

```
#let kebab-case = [Using hyphen]
#let _schön = "😊"
#let 始料不及 = "😱"
```

### Paths

| Path Type | Example | Resolves To |
|-----------|---------|-------------|
| Relative | `"utils.typ"` | Relative to **current file's directory** |
| Root-relative | `"/src/lib.typ"` | Relative to **project root** (set via `--root`) |
| Package | `"@preview/pkg:1.0"` | Typst Universe or local package cache |

```
// File structure:
// project/
// ├── main.typ
// └── src/
//     ├── lib.typ
//     └── utils.typ

// In main.typ:
#import "src/lib.typ": *      // Relative to main.typ
#import "/src/lib.typ": *     // Root-relative (same result with default root)

// In src/lib.typ:
#import "utils.typ": *        // Relative to lib.typ (finds src/utils.typ)
```

- **Project root**: parent directory of the main file. Use `typst compile --root .. file.typ` to override.
- Packages can only load files from their own directory. Pass resources as arguments (e.g., `logo: image("mylogo.svg")`).

#### Common Path Errors

| Error | Cause | Fix |
|-------|-------|-----|
| "file not found" | Wrong relative path | Check path relative to **current file**, not project root |
| "file not found" with `/` path | Root not set correctly | Use `--root .` or adjust path |
| "access denied" | File outside project root | Move file inside root or adjust `--root` |

---

## Styling: Set & Show Rules

### Set Rules

Configure default properties of elements. Only **optional** parameters can be set.

```
#set heading(numbering: "I.")
#set text(font: "New Computer Modern", size: 11pt)
#set page(paper: "a4", margin: (x: 2cm, y: 2.5cm))
#set par(justify: true)
#set list(marker: [--])
```

Set rules are scoped: nested inside a content block `[ .. ]`, they only apply until the end of that block.

#### Set-If Rules (conditional)

```
#let task(body, critical: false) = {
  set text(red) if critical
  [- #body]
}
```

### Show Rules

Transform how elements are rendered.

| Kind | Syntax | Effect |
|------|--------|--------|
| Show-set | `#show heading: set text(navy)` | Applies set rule only to selected elements |
| Transform | `#show heading: it => block[#emph(it.body)]` | Completely redefines rendering |
| Text replace | `#show "Project": smallcaps` | Replaces or styles literal text |
| Regex | `#show regex("\w+"): it => [*#it*]` | Selects text with regex |
| With fields | `#show heading.where(level: 1): set align(center)` | Selects only matching elements |
| By label | `#show <intro>: set text(red)` | Selects elements with that label |
| Everything | `#show: rest => columns(2, rest)` | Wraps everything after the rule |

**Good practice:** Keep show-set rules separate (they remain overridable). Avoid placing set rules inside a transformational show rule unless the styling must be final.

---

## Text & Fonts

```
#set text(
  font: ("Liberation Serif", "Times New Roman"),
  size: 11pt,
  fill: rgb("#333333"),
  lang: "ru",          // "en", "de", "fr", "es", etc.
  region: "RU",        // ISO country code
  weighted: false,
  tracking: 0.5pt,     // letter-spacing
)
```

Available text properties: `font`, `size`, `fill`, `lang`, `region`, `weight`, `style`, `stretch`, `tracking`, `spacing`, `baseline`, `overhang`, `top-edge`, `bottom-edge`, `fallback`, `synthetic-bold`, `synthetic-italic`, `synthetic-slant`, `number-type`, `number-width`, `slashed-zero`.

### Smart quotes

```
#set smartquote(quotes: "\"`" "\"'" `<<>>`)
#set text(lang: "ru")   // language changes quote convention automatically
```

---

## Page Layout

### Page Setup

```
#set page(
  paper: "a4",
  width: auto,          // default: 595.28pt (A4)
  height: auto,         // default: 841.89pt (A4)
  flipped: false,       // landscape when true
  margin: (x: 2cm, y: 2.5cm),
  // Individual: (top:, right:, bottom:, left:, inside:, outside:, rest:)
  binding: auto,        // auto → left for LTR, right for RTL
  columns: 1,
  fill: none,           // or a color for background
  numbering: "1",
  number-align: center + bottom,
  supplement: auto,     // used in page references
  header: none,         // auto shows page number if numbering set and align=top
  footer: auto,
  background: none,     // watermark or background image
  foreground: none,
)
```

### Standard Paper Sizes

`"a0"` through `"a10"`, `"iso-b1"` through `"iso-b8"`, `"iso-c3"` through `"iso-c8"`, `"us-letter"`, `"us-legal"`, `"us-tabloid"`, `"presentation-16-9"`, `"presentation-4-3"`, and many more.

### Headers & Footers

```
#set page(
  header: context [
    #set text(8pt)
    #smallcaps[Draft v2]
    #h(1fr)
    #counter(page).display()
  ],
  footer: context [
    #set align(left)
    Confidential — #counter(page).display("1 of I", both: true)
  ],
)
```

### Columns

```
// Two-column document
#set page(columns: 2)

// Local column switch inside a block
#columns(2)[
  #lorem(30)
]
```

### Page Breaks

```
#pagebreak()
#pagebreak(weak: true)   // only breaks if we're not already at top of page
```

---

## Headings

```
= Level 1
== Level 2
=== Level 3
==== Level 4
===== Level 5
```

### Numbering Patterns

```
#set heading(numbering: "1.")
#set heading(numbering: "1.1")
#set heading(numbering: "I.")
#set heading(numbering: "A.")
#set heading(numbering: "a)")
#set heading(numbering: "(I)")
```

Numbering uses Unicode-standard patterns: `1, 2, 3`, `I, II, III`, `i, ii, iii`, `A, B, C`, `a, b, c`, and custom symbols.

### Outline (Table of Contents)

```
#outline()
#outline(title: [Contents], depth: 2)
#outline(
  title: [Figures],
  target: figure.where(kind: image),
)
```

### Front Matter / Main Matter / Appendix

```
// Front matter: Roman numerals
#set page(numbering: "i")
#outline()
#pagebreak()

// Main matter: Arabic, reset counter
#set page(numbering: "1")
#counter(page).update(1)

// = Main sections...

// Appendix: letter-numbered headings
#counter(heading).update(0)
#set heading(numbering: "A.1")

= First Appendix
== Appendix subsection
```

---

## Lists

### Bullet List

```
- First item
- Second item
  - Nested item
  - Another nested
- Third item
```

### Numbered List

```
+ Step one
+ Step two
  + Sub-step
  + Sub-step
+ Step three
```

### Term List

```
/ Term: Description of the term.
/ Another term: Its description.
```

---

## Links & References

### Links

```
https://typst.app/               // auto-link
#link("https://typst.app/")[Typst]
#link("mailto:hello@typst.app")
```

### Labels & References

```
= Introduction <intro>
See the @intro for details.
See @intro for page #ref(<intro>, form: "page").
```

Labels can be placed on headings, figures, tables, equations, and any element:

```
#figure(image("plot.png"), caption: [Growth]) <fig:growth>
See @fig:growth.
```

---

## Code / Raw Blocks

```
`inline code`   // inline

```rust
fn main() {
    println!("Syntax highlighted!");
}
```              // block with language

```typst
#set text(font: "New Computer Modern")
= Hello
```              // Typst syntax highlighting
```

Raw block options (inline params after backticks):

````markdown
```typc
[theme: "dracula", lang: "rust", line-numbers: true]
```typc
````

Or using the function:

```
#raw("let x = 5", lang: "rust", theme: "solarized-light")
```

---

## Emphasis & Other Inline Formatting

| Syntax | Function | Effect |
|--------|----------|--------|
| `*text*` | `strong` | Bold |
| `_text_` | `emph` | Italic |
| `` `code` `` | `raw` | Monospace (code) |
| `#underline[text]` | `underline` | Underline |
| `#strike[text]` | `strike` | Strikethrough |
| `#smallcaps[text]` | `smallcaps` | Small capitals |
| `#sub[text]` | `sub` | Subscript |
| `#super[text]` | `super` | Superscript |
| `#box(width: 2cm, inset: 4pt)[text]` | `box` | Rectangular box |
| `#block(width: 100%)[text]` | `block` | Wrapped block (full width) |

```
This is *strong*, _emphasized_, and `code`.
Also #underline[underlined] and #strike[striked].
H#sub[2]O and E=mc#super[2].
```

---

## Math Typesetting

### Modes

| Syntax | Mode |
|--------|------|
| `$x^2$` | Inline math |
| `$ x^2 $` (surrounding spaces) | Block/display math |

### Variables & Symbols

- Single letters display as-is: `$ A = pi r^2 $`
- Multiple letters are interpreted as variables: use `$ "area" $` for multi-letter text.
- Prefix with `#` to access code variables: `$ #x < 17 $`
- Greek letters: `alpha`, `beta`, `gamma`, `Gamma`, `pi`, `Sigma`, `tau`, `omega`, `Omega`, etc.
- Shorthands: `->` (arrow), `=>` (double arrow), `!=` (not equal), `<=`, `>=`, `...` (ellipsis), `->>`, `-->`, `<->`.

### Attachments (Subscript & Superscript)

```
$ x_1 $                   // subscript
$ x^2 $                   // superscript
$ x_1^2 $                 // both
$ sum_(i=0)^n i $         // limits
$ lim_(x -> 0) f(x) $     // limits with arrow
```

### Fractions

```
$ (a+b)/5 $               // inline fraction
$ frac(a^2, 2) $          // function style
```

### Roots

```
$ sqrt(x) $               // square root
$ sqrt(x, 3) $            // nth root (cube root)
```

### Matrices & Vectors

```
$ mat(1, 2; 3, 4) $                       // 2×2 matrix
$ mat(1, 2, 3; 4, 5, 6) $                // 2×3 matrix
$ vec(1, 2, 3) $                          // column vector
$ vec(1, 2, delim: "[") $                 // with custom delimiters
$ mat(..#range(1, 5).chunks(2)) $         // computed matrix
```

### Cases

```
$ cases(
   x + y = 6,
   x - y = 4,
) $
```

### Binomial

```
$ binom(n, k) $
```

### Integrals, Sums, Products

```
$ integral_0^1 f(x) dif x $    // integral
$ sum_(k=0)^n k $              // sum
$ product_(i=1)^m i $          // product
$ union_(i=1)^n A_i $          // union
$ intersection_(i=1)^n A_i $   // intersection
```

### Operators

```
$ op("lim")_(x -> 0) f(x) $    // custom operator with limits
$ floor(x) $, $ ceil(x) $
```

### Delimiters (parentheses, brackets, braces)

```
$ lr(|x|) $                    // automatic sizing
$ lr((x+1)/5) $                // scales to content
$ lr([x, y]) $                 // brackets
$ lr({1, 2, 3}) $             // braces (escape with \?)
```

### Cancelling

```
$ cancel(x) $                  // diagonal line through expression
```

### Alignment in Equations

```
$ sum_(k=0)^n k
    &= 1 + ... + n \
    &= (n(n+1)) / 2 $
```
The `&` creates alignment points. Each `\` starts a new line.

### Math Font

```
#show math.equation: set text(font: "Fira Math")
$ sum_(i in NN) 1 + i $
```

### Accents

```
$ accent(x, hat) $         // x̂
$ accent(x, tilde) $       // x̃
$ accent(x, dot) $         // ẋ
$ accent(x, ddot) $        // ẍ
$ accent(x, vec) $         // x⃗
$ accent(x, bar) $         // x̄
```

### Equation Numbering with Labels

```
#set math.equation(numbering: "(1)")

$ integral_0^infinity e^(-x) dif x = sqrt(pi) / 2 $ <eq:gaussian>

As shown in @eq:gaussian.
```

Per-chapter figure/equation numbering:
```
#set figure(numbering: num => context {
  let ch = counter(heading.where(level: 1)).get().first()
  [#ch.#num]
})
```

### Accessibility (alt text)

```
#math.equation(
  alt: "E equals m c squared",
  block: true,
  $ E = m c^2 $,
)
```

---

## Theorem Environments (Custom)

Typst has no built-in theorem environment. Build your own with counters and blocks.

### Simple Theorem Block

```
#let theorem-counter = counter("theorem")

#let theorem(body, name: none) = {
  theorem-counter.step()
  block(
    width: 100%,
    inset: 10pt,
    stroke: (left: 2pt + black),
    {
      context {
        let num = theorem-counter.display()
        [*Theorem #num*]
        if name != none [ _(#name)_]
        [*.* ]
      }
      emph(body)
    },
  )
}

#theorem[Every even integer greater than 2 is the sum of two primes.]
```

### Proof Block

```
#let proof(body) = block(
  width: 100%,
  inset: (left: 10pt),
  {
    [_Proof._ ]
    body
    h(1fr)
    $square$
  },
)

#proof[
  By contradiction, assume...
]
```

### Factory Pattern: Shared Counter

```
#let thm-counter = counter("theorem")

#let make-env(kind) = (body, name: none) => {
  thm-counter.step()
  block(
    width: 100%,
    inset: 10pt,
    stroke: (left: 2pt + black),
    {
      context {
        let num = thm-counter.display()
        [*#kind #num*]
        if name != none [ _(#name)_]
        [*.* ]
      }
      if kind == "Theorem" or kind == "Lemma" { emph(body) } else { body }
    },
  )
}

#let theorem = make-env("Theorem")
#let lemma = make-env("Lemma")
#let definition = make-env("Definition")

#definition[A group is a set $G$ with a binary operation...]
#theorem[Every finite group of prime order is cyclic.]
```

## Quotes & Admonitions

### Block Quote

```
#quote(block: true)[
  To be or not to be.
]

// With attribution
#quote(block: true, attribution: [Shakespeare])[
  To be or not to be.
]
```

### Custom Callout / Note Box

```
#let note(body) = block(
  fill: rgb("#e8f4f8"),
  inset: 1em,
  radius: 4pt,
  width: 100%,
)[*Note:* #body]

#note[Remember to save your work.]
```

---

## Tables

### Basic Table

```
#table(
  columns: (1fr, auto, auto),
  inset: 10pt,
  align: horizon,
  [Name], [Age], [Score],
  [Alice], [28], [95],
  [Bob], [32], [87],
)
```

### Table with Header (repeatable across pages)

```
#table(
  columns: 3,
  table.header(
    [*Name*], [*Age*], [*Score*],
  ),
  [Alice], [28], [95],
  [Bob], [32], [87],
  [Charlie], [24], [92],
)
```

### Table with Footer

```
#table(
  columns: 3,
  table.header([*Item*], [*Qty*], [*Price*]),
  [Widget], [5], [$10.00],
  [Gadget], [3], [$15.00],
  table.footer([Total], [], [$95.00]),
)
```

### Striped Table

```
#table(
  columns: 4,
  fill: (x, y) => if calc.odd(y) { luma(240) } else { white },
  align: (x, y) => if y == 0 { center } else if x == 0 { left } else { right },
  [], [*Q1*], [*Q2*], [*Q3*],
  [Revenue:], [1000 €], [2000 €], [3000 €],
  [Expenses:], [500 €], [1000 €], [1500 €],
  [Profit:], [500 €], [1000 €], [1500 €],
)
```

### Cell Spanning

```
#table(
  columns: 3,
  table.header([Substance], [Subcritical °C], [Supercritical °C]),
  [Hydrochloric Acid], [12.0], [92.1],
  table.cell(colspan: 2, fill: green.lighten(60%))[Mixed Value],
)
```

### Custom Cell via `table.cell`

```
#table(
  columns: 2,
  align: center,
  table.header([*Item*], [*Value*]),
  table.cell(
    align: right,
    fill: fuchsia.lighten(80%),
    [Special],
  ),
  [Normal],
)
```

### Table Lines (hline, vline)

```
#table(
  stroke: none,
  columns: (auto, 1fr),
  [09:00], [Opening],
  [10:00], [Keynote],
  table.hline(stroke: 0.6pt),
  [Noon], [Lunch],
  table.hline(stroke: 0.6pt, start: 1),
  [14:00], [Workshop],
)
```

### Grid (for layouts that aren't semantically tables)

`#grid` shares the same syntax as `#table` but without header/footer semantics and different defaults for `stroke` and `inset`.

```
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  [A], [B], [C],
  [D], [E], [F],
)
```

---

## Figures & Cross-References

### Figure with caption

```
#figure(
  image("plot.png", width: 60%),
  caption: [Quarterly growth],
) <fig:growth>
```

### Referencing figures

```
See @fig:growth for details.
As shown in @fig:growth.
```

### Table as figure

```
#figure(
  table(
    columns: 2,
    [A], [B],
    [1], [2],
  ),
  caption: [Comparison table],
) <tab:comparison>
```

### Equation as figure

```
#figure(
  $ E = m c^2 $,
  caption: [Mass-energy equivalence],
) <eq:einstein>
```

---

## Bibliographies & Citations

### Adding bibliography

```
#bibliography("references.bib")
#bibliography("references.yaml")
#bibliography(("refs.bib", "articles.yaml"))
```

#### Data Loading (CSV/JSON)

```
// CSV returns arrays of strings
#let data = csv("data.csv")
// → (("Name","Score"), ("Alice","95"), ...)

// JSON preserves types (int, bool, etc.)
#let data = json("data.json")
// → ((name: "Alice", score: 95), ...)

// Generate table from loaded data
#table(
  columns: 2,
  [*Name*], [*Score*],
  ..data.map(row => (row.name, str(row.score))).flatten(),
)
```

### Citation styles

```
#bibliography("ref.bib", style: "ieee")
#bibliography("ref.bib", style: "apa")
#bibliography("ref.bib", style: "gost-r-705-2008-numeric")
#bibliography("ref.bib", style: "chicago-author-date")
#bibliography("ref.bib", style: "mla")
```

Full list of built-in styles: `ieee`, `apa`, `mla`, `chicago-author-date`, `chicago-notes`, `harvard-cite-them-right`, `vancouver`, `nature`, `springer-basic`, `elsevier-harvard`, `american-physics-society`, `gost-r-705-2008-numeric`, `iso-690-author-date`, and 60+ more. Custom CSL files also supported.

### Citing

```
This was noted earlier. @smith2023
Multiple sources @smith2023 @jones2022.
See #cite(<key>, form: "prose") for a discussion.

// With page/location supplement
See @smith2023[pp. 42-45].
```

### Bibliography title

```
#bibliography("ref.bib", title: [References])
#bibliography("ref.bib", title: auto)     // auto-localized title
#bibliography("ref.bib", title: none)     // no title
```

### Including uncited works

```
#bibliography("ref.bib", full: true)
```

---

## Scripting & Programming

### Variables & Constants

```
#let name = "Typst"
#let version = 0.12
#let count = 42
#let is_active = true
#let items = ("a", "b", "c")
#let config = (title: "Hello", font: "Serif")
```

### Functions

```
// Named function
#let greet(name) = [
  Hello, #name!
]

// Function with body block
#let format-text(body, size: 11pt) = {
  set text(size: size)
  body
}

// Unnamed (anonymous) function
#let transform = (x => x * 2)
#let transform = (x, y) => {
  x + y
}
```

### Conditionals

```
#if is_active [
  Active!
] else [
  Inactive.
]

#let status = if x > 10 { "big" } else { "small" }

#if x == true [
  Yes
] else if y == true [
  Maybe
] else [
  No
]
```

### Loops

```
// For loop over array
#for item in items [
  - #item
]

// For with index
#for i, item in items.enumerate() [
  #i. #item
]

// For loop over dictionary
#for (key, value) in dict [
  #key = #value
]

// While loop
#let i = 0
#while i < 5 [
  #i \
  #(i = i + 1)
]

// Break and Continue
#for item in items [
  if item == "skip" [continue]  
  if item == "stop" [break]    
  [- #item]
]

// Fold for accumulation (workaround for closure mutability)
#let sum = items.fold(0, (acc, x) => acc + x)
```

### Content Blocks

```
#let info(title, body) = [
  == #title
  #body
]

// Passing content as body:
#info([Introduction])[
  This is the introduction paragraph.
]
```

### Including & Importing

```
#import "utils.typ"           // imports all
#import "utils.typ": greet   // imports specific items
#include "chapter1.typ"      // includes content directly
```

**Scope difference**: `include` inserts file content directly but **variables from included files do not leak** to the parent scope. Use `import` to share variables.

```
// chapters/intro.typ — content file
This is chapter 1.

// vars.typ — module file
#let shared-title = "Intro"

// main.typ
#include "chapters/intro.typ"
#shared-title  // Error! Include does not leak variables

// Correct approach:
#import "vars.typ": shared-title
#shared-title  // Works
```

Use `include` for document content, `import` for reusable functions/variables.

### Context expressions (for dynamic content)

```
#context text.lang            // get the current text language
#context counter(page).get()  // get current page number
```

### Metadata for CLI Query

Use `#metadata(value)` to attach invisible data to labels. Query from CLI with `typst query`.

```
#metadata((title: "Report", version: "2.1.0")) <doc-info>
```

```bash
# Extract metadata as JSON
typst query doc.typ "<doc-info>" --field value --one --pretty
# → {"title": "Report", "version": "2.1.0"}
```

---

## Standard Data Types

| Type | Examples | Notes |
|------|----------|-------|
| `none` | `none` | Absence of value |
| `auto` | `auto` | Smart default |
| `bool` | `true`, `false` | Boolean |
| `int` | `10`, `0xff` | Whole numbers |
| `float` | `3.14`, `1e5` | Floating-point |
| `decimal` | `100.00` | Fixed-point decimal |
| `length` | `2pt`, `3mm`, `1em`, `1cm`, `1in` | Physical dimensions |
| `angle` | `90deg`, `1rad` | Angle |
| `fraction` | `2fr` | Fractional space |
| `ratio` | `50%` | Percentage |
| `str` | `"hello"` | Unicode string |
| `content` | `[*Hello*]` | Markup content |
| `array` | `(1, 2, 3)` | Sequence of values |
| `dictionary` | `(a: "hi", b: 2)` | Key-value map |
| `color` | `red`, `rgb("#ff0000")`, `luma(128)` | Color |
| `gradient` | `gradient.linear(..)` | Color gradient |
| `datetime` | `datetime(year: 2025, month: 1, day: 15)` | Date/time |
| `duration` | `1h + 30min` | Time span |
| `version` | `version("0.12.0")` | Software version |
| `regex` | `regex("\w+")` | Regular expression |
| `label` | `<intro>` | Element label |
| `selector` | `heading.where(level: 1)` | Element selector |
| `function` | `x => x + 1` | Callable function |
| `module` | `import` result | Collection of functions |

### Color operations

```
#let c = rgb("#336699")
c.lighten(20%)      // lighter version
c.darken(20%)       // darker version
c.saturate(50%)     // more saturated
c.desaturate(50%)   // less saturated
c.transparentize(50%) // semi-transparent
```

### Common Pitfalls

**Mutability in closures**: Closures cannot modify captured variables.
```
// WRONG
#let results = ()
#let add(x) = { results.push(x) }  // Error!

// CORRECT — use fold
#let results = items.fold((), (acc, item) => {
  acc.push(item)
  acc
})
```

**Content vs String**: Content brackets are literal text — code is not evaluated inside.
```
[1 + 2]             // Shows literal "1 + 2"
[Result: #(1 + 2)]  // Shows "Result: 3"

#let result = [#prefix#body#suffix]       // content concatenation
#let combined = prefix-str + body-str     // string concatenation

// Check empty
#let is-empty(x) = { x == none or x == "" or x == [] }
```

**None returns**: Functions without explicit return value return `none`.
```
#let maybe(x) = {
  if x > 0 { x }
  // Returns none if x <= 0
}

#let result = maybe(-1)
#if result != none [Got: #result] else [No result]
```

---

## Packages (Typst Universe)

Import packages using `@preview` convention:

```
#import "@preview/cetz:0.3.1"
#import "@preview/fletcher:0.5.4"
#import "@preview/polylux:0.3.1"
#import "@preview/tablem:0.1.1"
#import "@preview/codly:1.1.1"
#import "@preview/modern-g7-32:0.2.0": gost, abstract, appendixes
```

### Key Packages

| Package | Purpose | Import |
|---------|---------|--------|
| **CeTZ** | Drawing figures, plots, diagrams (TikZ-like) | `"cetz"` |
| **Fletcher** | Flowcharts, state diagrams, commutative diagrams | `"fletcher"` |
| **Polylux** | Slide presentations with themes and transitions | `"polylux"` |
| **Codly** | Code blocks with line numbers, icons, and themes | `"codly"` |
| **Tablem** | Markdown-like table syntax | `"tablem"` |
| **Physica** | Physics notation utilities | `"physica"` |
| **mitex** | LaTeX math compatibility mode | `"mitex"` |
| **lineno** | Line numbers for documents | `"lineno"` |
| **subpar** | Sub-figures within a figure block | `"subpar"` |
| **Modern-g7-32** | GOST 7.32-2017 academic documents (Russian) | `"modern-g7-32"` |

Always use the latest stable version from `https://typst.app/universe`. Check the package's documentation for version-specific features.

---

## Project-Specific: GOST 7.32-2017 (`modern-g7-32`)

This project uses the `@preview/modern-g7-32` package for GOST 7.32-2017 compliant academic reports.

### Quick Reference

```
#import "@preview/modern-g7-32:0.2.0": abstract, appendix-heading, appendixes, enum-numbering, gost

#set enum(numbering: enum-numbering)

#show: gost.with(
  ministry: "...",
  organization: (full: "...", short: "..."),
  subject: "...",
  city: "...",
  performers: ((name: "...", position: "..."),),
)

#abstract(keywords...)[text]
#outline()
// ... body ...
#bibliography("references.bib")
#show: appendixes
= Appendix
```

### For complete documentation

Read the dedicated **`gost-7-32-guide.md`** file in this skill directory — it covers:
- All 20+ `gost.with()` parameters with types and descriptions
- `abstract`, `appendixes`, `appendix-heading`, `enum-numbering` exports
- Performer structure (single/multiple, organizations, co-performers)
- Title page configuration and custom templates
- Appendix sections with Cyrillic numbering and status
- Alternative figure numbering, DOCX export

### Template

The `templates/gost-report.typ` provides a complete ready-to-use GOST report with all template parameters pre-filled (replace placeholders).

---

## Compilation & CLI

### Commands

```
# Compile to PDF
typst compile main.typ
typst compile main.typ output.pdf
typst compile main.typ --root ..

# Watch mode (live recompile on changes)
typst watch main.typ

# Compile to PNG (per-page images)
typst compile main.typ output-{n}.png
typst compile main.typ --pages 1-3 output-{n}.png

# Compile to SVG
typst compile main.typ output.svg

# Query document metadata
typst query main.typ "<intro>"    // get heading labels
typst query main.typ --field value

# List available fonts
typst fonts

# Font diagnostics
typst fonts --variant
```

### Common Flags

| Flag | Purpose |
|------|---------|
| `--root <dir>` | Set project root directory |
| `--font-path <path>` | Add font directory |
| `--pages <spec>` | Page range (e.g., `1-3`, `1,3,5-7`) |
| `--ppi <num>` | PNG resolution (default 144) |
| `--open` | Open output after compilation |
| `--diagnostics` | Get structured diagnostics |

### Debugging & Verification

Since agents cannot preview PDFs directly, use these methods:

| Method | Command | Best For |
|--------|---------|----------|
| HTML export | `typst compile doc.typ /dev/stdout -f html --features html 2>/dev/null` | Text content, structure, headings, tables, data correctness |
| PNG export | `typst compile doc.typ "page-{p}.png" -f png` | Visual layout, alignment, spacing, fonts, page breaks |
| pdftotext | `typst compile doc.typ && pdftotext doc.pdf -` | Plain text fallback, page-count checks |

Use `#repr(value)` to inspect any value during development:
```
#let debug-value(v) = {
  text(fill: red, size: 8pt)[[#type(v)] #repr(v)]
}
#debug-value((a: 1, b: (2, 3)))
// Output: [dictionary] (a: 1, b: (2, 3))
```

### Common Errors

| Error | Cause | Fix |
|-------|-------|-----|
| "unknown variable" | Undefined identifier | Check spelling, ensure `#let` before use |
| "expected X, found Y" | Type mismatch | Check function signature in docs |
| "file not found" | Bad import path | Paths resolve relative to current file, not project root |
| "unknown font" | Font not installed | Use `typst fonts` to list; add with `--font-path` |
| "maximum function call depth exceeded" | Deep recursion | Use iteration instead |
| "can only be used when context is known" | Missing `context` wrapper | Wrap in `context { ... }` |
| "unexpected argument" | `=` instead of `:` for args | Named args use `:` syntax: `func(name: value)` |
| "variables from outside are read-only" | Mutating captured variable | Use `fold()` or `state()` |
| "expected content, found string" | Content/string type mismatch | Use `[#str-var]` to embed string in content |
| set/show rule has no effect | Rule placed after content | Place set/show rules **before** the content they target |

### CI / Reproducible Builds

```bash
# Reproducible compilation with pinned cache and timestamp
typst compile doc.typ out.pdf --root . \
  --creation-timestamp "$SOURCE_DATE_EPOCH" \
  --package-cache-path ./.typst-cache \
  --deps deps.json --deps-format json

# PDF standards
typst compile doc.typ out.pdf --pdf-standard a-4
typst compile doc.typ out.pdf --pdf-standard ua-1

# Initialize from template
typst init @preview/charged-ieee
typst init @preview/charged-ieee:0.1.0 my-paper
```

### `typst query` — Extract Document Data

Query compiled documents for structured data as JSON. Essential for CI, multi-pass builds, and metadata extraction.

```bash
# Query all headings
typst query doc.typ "heading"

# Query specific label
typst query doc.typ "<my-label>" --field value --one

# Filtered query
typst query doc.typ "heading.where(level: 1)"

# Extract with field selection
typst query doc.typ "<version>" --field value --one
# → "1.0.0"

# Pretty-print JSON
typst query doc.typ "<doc-info>" --field value --one --pretty
# → {"title": "Report", "status": "draft"}

# Multi-pass compilation (Page X of N)
typst query doc.typ "<page-count>" --field value --one
# Feed back:
typst compile main.typ --input "total-pages=$PAGES"

# Pass inputs for conditional compilation
typst query doc.typ "<ci-meta>" --field value --one --input mode=ci
```

---

## Templates

This skill includes the following templates in `templates/`:

| Template | File | Purpose |
|----------|------|---------|
| Scientific Report | `templates/scientific-report.typ` | Academic paper with abstract, sections, bibliography |
| Presentation | `templates/presentation.typ` | Polylux-based slide deck |
| CV / Resume | `templates/cv.typ` | Professional curriculum vitae |
| GOST 7.32 Report | `templates/gost-report.typ` | GOST-compliant report with title page, appendixes |

Read a template and customize it when the user needs a starting point for a new document.

---

## LaTeX → Typst Reference

### Package Equivalences

| LaTeX Package | Typst Alternative |
|---------------|-------------------|
| `graphicx`, `svg` | `#image()` function (built-in) |
| `tabularx`, `tabularray` | `#table()`, `#grid()` (built-in) |
| `amsmath`, `amssymb` | Built into math mode |
| `hyperref` | `#link()` function (built-in) |
| `biblatex`, `natbib` | `#cite()`, `#bibliography()` (built-in) |
| `geometry`, `fancyhdr` | `#set page(margin: ..., header: ..., footer: ...)` |
| `xcolor` | `#set text(fill: rgb("#..."))`, `luma()`, etc. |
| `babel`, `polyglossia` | `#set text(lang: "zh")` |
| `lstlisting`, `minted` | `#raw()` function, backtick code blocks |
| `caption` | `#figure(caption: ...)` (built-in) |
| `enumitem` | `#list()`, `#enum()`, `#terms()` parameters |
| `parskip` | `#set par(spacing: ..., first-line-indent: ...)` |
| `nicefrac` | `frac(a, b, style: "horizontal")` |
| `csquotes` | Smart quotes auto-active; set `text(lang: ...)` |
| `tikz`, `pgf` | `@preview/cetz` package |
| `amsthm` | Custom with counters (see below) |

### Concept Mappings

| LaTeX | Typst |
|-------|-------|
| `\textbf{x}` | `*x*` (semantic) or `#text(weight: "bold")[x]` (style-only) |
| `\emph{x}` | `_x_` or `#emph[x]` |
| `\textit{x}` | `#text(style: "italic")[x]` |
| `\bfseries` | `#set text(weight: "bold")` in current scope |
| `\textsc{x}` | `#smallcaps[x]` |
| `\left( ... \right)` | Auto-scaling in math; use `lr(( ))` to force |
| `\documentclass{article}` | `#show: template.with(...)` (from a template) |
| `\newcommand{\foo}{...}` | `#let foo = ...` or `#let foo(x) = ...` |
| `\textbf{bold}` | `*bold*` |
| `\section{Heading}` | `= Heading` |
| `\begin{equation} ... \end{equation}` | `$ ... $` (block math) |
| `\frac{a}{b}` | `frac(a, b)` |
| `\sqrt{x}` | `sqrt(x)` |
| `\sum_{i=1}^{n}` | `sum_(i=1)^n` |
| `\alpha` | `alpha` |
| `\begin{tabular}` | `#table(columns: ..., ...)` |
| `\cite{key}` | `@key` |
| `\bibliography{file}` | `#bibliography("file.bib")` |
| `\label{fig:1}` | `<fig:1>` |
| `\ref{fig:1}` | `@fig:1` |
| `\begin{enumerate}` | `+ item` |
| `\begin{itemize}` | `- item` |
| `\usepackage{package}` | `#import "@preview/package:version"` |
| `\text{...}` in math | `"..."` in math |
| `\\[2mm]` | `#v(2mm)` |
| `\hspace{1cm}` | `#h(1cm)` |
| `\vspace{1cm}` | `#v(1cm)` |
| `\centering` | `#set align(center)` |
| `\includegraphics[width=0.5\textwidth]{file}` | `#image("file", width: 50%)` |

### "LaTeX look" starter

Reproduces the Computer Modern / justified look of a classic LaTeX article:

```
#set page(margin: 1.75in)
#set par(leading: 0.55em, spacing: 0.55em, first-line-indent: 1.8em, justify: true)
#set text(font: "New Computer Modern")
#show raw: set text(font: "New Computer Modern Mono")
```

### Using Pandoc for Conversion

Pandoc (since v2.18) supports Typst as an output format.

```bash
# Markdown → Typst
pandoc -f markdown -t typst input.md -o output.typ

# LaTeX → Typst
pandoc -f latex -t typst input.tex -o output.typ

# Markdown → PDF via Typst
pandoc input.md -o output.pdf --pdf-engine=typst
```

Customizable options:
```bash
pandoc input.md -t typst -o output.typ \
  -V papersize=a4 -V fontsize=12pt \
  -V mainfont="Libertinus Serif" \
  -V section-numbering="1.1" --toc
```

Known limitations: citations use `#cite(<ref>)` syntax; complex tables need manual adjustment; raw Typst blocks use ```` ```{=typst} ```` fenced blocks. Review and refine Pandoc output.
