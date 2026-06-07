# GOST 7.32-2017 Template Guide

Complete reference for the `modern-g7-32` package (v0.2.0) from [typst-gost.ru](https://typst-gost.ru), used in this project for GOST-compliant academic documents.

> **Minimum Typst version**: 0.14.0

---

## Quick Start

```typst
#import "@preview/modern-g7-32:0.2.0": abstract, appendix-heading, appendixes, enum-numbering, gost

// Cyrillic numbering for lists
#set enum(numbering: enum-numbering)

#show: gost.with(
  ministry: "Наименование министерства",
  organization: (
    full: "Полное наименование организации",
    short: "Сокращённое наименование",
  ),
  report-type: "отчёт",
  about: "О научно-исследовательской работе",
  research: "Наименование НИР",
  subject: "Наименование отчёта",
  manager: (name: "И.О. Фамилия", position: "Должность"),
  city: "Город",
)

#abstract("ключевое1", "ключевое2")[
  Текст реферата...
]

#outline()

= Введение
...

#bibliography("references.bib")

#show: appendixes

= Первое приложение
...
```

---

## Import

```typst
#import "@preview/modern-g7-32:0.2.0": abstract, appendix-heading, appendixes, enum-numbering, gost
```

Available exports:
- **`gost`** — main template function, used with `.with()` via `#show: gost.with(...)`
- **`abstract`** — generates abstract block with auto-statistics
- **`appendixes`** — show rule for appendix section (Cyrillic numbering, independent counters)
- **`appendix-heading`** — custom heading for appendices with status (e.g., "справочное")
- **`enum-numbering`** — Cyrillic numbering pattern for `#set enum(numbering: enum-numbering)`

---

## `gost.with()` Parameters

### Required / Core Parameters

| Parameter | Type | Description |
|-----------|------|-------------|
| `ministry` | `str` | Ministry or department name |
| `organization` | `(full: str, short: str)` | Full and short organization name |
| `report-type` | `str` | Type of report (e.g., "отчёт", "отчёт о НИР") |
| `about` | `str` | Short description (e.g., "О научно-исследовательской работе") |
| `research` | `str` | Research topic name |
| `subject` | `str` | Report subject/title |
| `manager` | `(name: str, position: str, title: str)` | Project manager details |
| `performers` | `array` | List of performers (see below) |
| `city` | `str` | City of publication |

### Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `udk` | `str` | — | UDC index |
| `research-number` | `str` | — | Research registration number |
| `report-number` | `str` | — | Report registration number |
| `approved-by` | `(name: str, position: str, year: int \| auto)` | — | Approval stamp |
| `agreed-by` | `(name: str, position: str, year: int \| auto)` | — | Agreement stamp |
| `bare-subject` | `bool` | `false` | Remove "по теме" prefix |
| `year` | `int \| auto` | `auto` | Document year (auto = current year) |
| `stage` | `(type: str, num: int)` | — | Report stage info |
| `federal` | `str` | — | Federal program name |
| `part` | `int` | — | Book/part number |
| `hide-title` | `bool` | `false` | Hide the title page |
| `text-size` | `(default: length, small: length)` | `(default: 14pt, small: 10pt)` | Font sizes |
| `indent` | `length` | `1.25cm` | Paragraph indent |
| `title-footer-align` | `alignment` | `center` | Footer alignment on title page (city & year) |
| `pagination-align` | `alignment` | `center` | Page number alignment |
| `margin` | `(left:, right:, top:, bottom:)` | GOST defaults | Page margins |
| `add-pagebreaks` | `bool` | `true` | Automatic section page breaks |

### Performers Structure

Each performer can be a **string** (organization name) or a **dictionary**:

```typst
performers: (
  "Организация",  // organization name (following performers belong to it)
  (
    name: "И.О. Фамилия",
    position: "Должность",
    part: "введение, раздел 1",  // optional: sections they contributed to
    co-performer: true,           // optional: mark as co-performer
    title: "должность",          // optional: role title on title page
  ),
)
```

If only **one performer** is listed, they are moved to the title page.

### Using `auto` with Dates

```typst
year: auto,                    // automatically uses current year
approved-by: (name: "...", position: "...", year: auto),  // auto year
agreed-by: (name: "...", position: "...", year: auto),
```

Omit any optional parameter entirely to exclude it from the title page.

---

## Abstract

```typst
#abstract("keyword1", "keyword2", "keyword3")[
  Full text of the abstract.
  The template automatically counts words, pages,
  figures, tables, and sources.
]
```

---

## Outline (Table of Contents)

```typst
#outline()          // standard outline
#outline(depth: 3)  // with depth limit
```

The outline is automatically formatted per GOST requirements (dot leaders, proper indentation).

---

## Document Body Structure

Use standard Typst headings (`=`, `==`, `===`) for sections.

```typst
= Введение
Текст введения...

= Основная часть
== Глава 1
Текст главы...
=== Пункт 1.1
...
```

---

## Elements (Figures, Tables, Code, Equations)

All elements follow GOST requirements automatically (numbering, captions, spacing).

### Images

```typst
#figure(
  image("images/diagram.png", width: 60%),
  caption: [Название рисунка],
) <fig:label>
```

### Tables

```typst
#figure(
  table(
    columns: 4,
    table.header([Заголовок 1], [Заголовок 2], [Заголовок 3], [Заголовок 4]),
    [Данные], [Данные], [Данные], [Данные],
  ),
  caption: [Название таблицы],
) <tab:label>
```

### Code Listings

```typst
#figure(
  ```python
  print("Hello, GOST!")
  ```,
  caption: [Название листинга],
) <code:label>
```

### Equations

```typst
$ sum_(k=0)^n k = 1 + ... + n = (n(n+1)) / 2 $
<eq:label>
```

---

## Bibliography

```typst
// At the end of the document, before appendixes
#bibliography("references.bib")
```

Uses standard Typst citation syntax: `@key` for citing, supports `.bib` and `.yaml` formats.

---

## Appendixes

### Basic Appendix Section

```typst
#show: appendixes

= Первое приложение
Содержание приложения...

== Подраздел приложения
...
```

The `appendixes` show rule:
- Switches heading numbering to Cyrillic letters (А, Б, В...)
- Skips forbidden letters (Ё, Й, О, Ч, Ъ, Ы, Ь)
- Uses independent figure/table/equation counters
- Adds appendixes to the table of contents

### Appendix Heading with Status

```typst
#appendix-heading("справочное", level: 1)[Приложение с указанием статуса]

#appendix-heading("справочное", level: 2)[Подприложение со статусом]
```

Parameters: `status` (str) — appendix type (e.g., "справочное", "обязательное"), `level` (int) — heading level (default: 1).

---

## Custom Title Page Templates

Create reusable title page configurations:

```typst
#let my-title = gost.with(
  ministry: "...",
  // ... common settings
)

// Use in documents:
#show: my-title
```

For advanced custom templates (e.g., different title page layouts), see the `@preview/modern-g7-32` package source or create a wrapper template:

```typst
#let my-report(
  title: none,
  author: none,
  body,
) = {
  set enum(numbering: enum-numbering)
  show: gost.with(
    ministry: "...",
    performers: (if author != none { (name: author, position: "") } else { () }),
    subject: if title != none { title } else { "" },
  )
  body
}
```

---

## Alternative Figure Numbering

By default, figures are numbered sequentially (1, 2, 3...). To use per-section numbering (1.1, 1.2, 2.1...):

```typst
// Enable per-section numbering
#set figure(numbering: "1.1")

// Or chapter-linked numbering
#set figure(numbering: num => context {
  let ch = counter(heading.where(level: 1)).get().first()
  [#ch.#num]
})
```

---

## Export to DOCX

Use Pandoc for DOCX export (for norm-control requiring Word format):

```bash
# Typst → PDF → DOCX conversion workflow
typst compile document.typ
pandoc document.typ -o document.docx       # direct (requires recent Pandoc)
# Or via intermediate formats:
typst compile document.typ /dev/stdout -f html --features html 2>/dev/null \
  | pandoc -f html -o document.docx
```

Note: Direct Pandoc conversion may lose GOST-specific formatting. Manual adjustments in Word are typically needed.

---

## Import Map

```typst
// Standard import for this project
#import "@preview/modern-g7-32:0.2.0": abstract, appendix-heading, appendixes, enum-numbering, gost

// Full example (from this project's main.typ)
#set enum(numbering: enum-numbering)
#show: gost.with(...)

#abstract(keywords...)[text]
#outline()

// ... document body ...

#bibliography("references.bib")
#show: appendixes
= Appendix A
...

// Or with status:
#appendix-heading("справочное", level: 1)[Appendix with status]
```
