// GOST 7.32-2017 Report Template
//
// Complete template for GOST-compliant academic documents
// using the modern-g7-32 package.
//
// Usage:
//   1. Fill in the gost.with() parameters below
//   2. Write sections using =, ==, === headings
//   3. Add a bibliography file and cite with @key
//   4. Compile: typst compile gost-report.typ
//
// For full reference, see ../gost-7-32-guide.md

#import "@preview/modern-g7-32:0.2.0": abstract, appendix-heading, appendixes, enum-numbering, gost

// Cyrillic numbering for enumerations (ГОСТ requirement)
#set enum(numbering: enum-numbering)

// ========================================
// TITLE PAGE CONFIGURATION
// ========================================
#show: gost.with(
  // --- Organization ---
  ministry: "Наименование министерства (ведомства) или другого структурного образования, в систему которого входит организация-исполнитель",
  organization: (
    full: "Полное наименование организации — исполнителя НИР",
    short: "Сокращённое наименование организации",
  ),

  // --- Document identifiers ---
  udk: "индекс УДК",
  research-number: "регистрационный номер НИР",
  report-number: "регистрационный номер отчета",

  // --- Approval stamps ---
  approved-by: (
    name: "Фамилия И.О.",
    position: "Должность, наимен. орг.",
    year: auto,
  ),
  agreed-by: (
    name: "Фамилия И.О.",
    position: "Должность, наимен. орг.",
    year: auto,
  ),

  // --- Report info ---
  report-type: "отчёт",
  about: "О научно-исследовательской работе",
  research: "Наименование НИР",
  bare-subject: false,
  subject: "Наименование отчёта",

  // --- Manager ---
  manager: (
    name: "Фамилия И.О.",
    position: "Должность",
    title: "Руководитель НИР,",
  ),

  // --- Date and stage ---
  year: auto,
  stage: (type: "вид отчёта", num: 1),
  federal: "Наименование федеральной программы",
  part: 1,
  city: "Город",

  // --- Visual setup ---
  text-size: (default: 14pt, small: 10pt),
  indent: 1.25cm,
  hide-title: false,
  title-footer-align: center,
  pagination-align: center,
  margin: (
    left: 30mm,
    right: 15mm,
    top: 20mm,
    bottom: 20mm,
  ),
  add-pagebreaks: true,

  // --- Performers ---
  performers: (
    "Всероссийский институт научной и технической информации " + "Российской академии наук (ВИНИТИ РАН)",
    (
      name: "И.О. Фамилия",
      position: "Должность",
      part: "введение, раздел 1",
    ),
    (name: "И.О. Фамилия", position: "Должность"),
    "Другая организация",
    (name: "И.О. Фамилия", position: "Должность"),
    (
      name: "И.О. Фамилия",
      position: "Должность",
      co-performer: true,
    ),
  ),
)

// ========================================
// ABSTRACT
// ========================================
#abstract(
  "ключевое слово",
  "шаблон",
  "typst",
  "государственные стандарты",
  "оформление документов",
)[
  Настоящий документ представляет собой описание шаблона modern-g7-32,
  разработанного для системы вёрстки #link("https://typst.app/")[Typst]
  с целью автоматизации создания документов, соответствующих
  государственным стандартам.

  В документе рассмотрены основные элементы шаблона, включая оформление
  таблиц, блоков кода и изображений, а также детально описана работа с
  аргументами функции `gost.with` для кастомизации титульной страницы.
]

// ========================================
// TABLE OF CONTENTS
// ========================================
#outline()

// ========================================
// MAIN BODY
// ========================================
= Введение

Текст введения. Шаблон modern-g7-32 предназначен для создания документов
в строгом соответствии с ГОСТ 7.32-2017. Он упрощает оформление
титульного листа, автоматизирует подстановку даты и позволяет легко
управлять отображением информации.

== Цель работы

Целью данной работы является...

= Основная часть

== Раздел 1

=== Пункт 1.1

Текст пункта, описание методики, результатов и т.д.

=== Пункт 1.2

// Example: Table
#figure(
  table(
    columns: 4,
    table.header([Заголовок 1], [Заголовок 2], [Заголовок 3], [Заголовок 4]),
    [Данные], [Данные], [Данные], [Данные],
    [Данные], [Данные], [Данные], [Данные],
    [Данные], [Данные], [Данные], [Данные],
  ),
  caption: [Пример таблицы с данными],
) <example-table>

== Раздел 2

// Example: Image
#figure(
  image("images/example.jpg", width: 60%),
  caption: [Пример изображения],
) <example-image>

// Example: Code listing
#figure(
  ```python
  def hello():
      print("Hello, world!")
  ```,
  caption: [Пример кода на Python],
) <example-code>

// Example: Equation
$ sum_(k=0)^n k = 1 + ... + n = (n(n+1)) / 2 $
<example-formula>

= Заключение

В данной работе было рассмотрено... @example-source

// ========================================
// REFERENCES
// ========================================
#bibliography("references.bib")

// ========================================
// APPENDIXES
// ========================================
#show: appendixes

= Первое приложение

Содержание первого приложения.

== Подраздел приложения

// Appendix table
#figure(
  table(
    columns: 4,
    table.header([Заголовок 1], [Заголовок 2], [Заголовок 3], [Заголовок 4]),
    [Данные], [Данные], [Данные], [Данные],
  ),
  caption: [Пример таблицы в приложении],
) <appendix-table>

= Второе приложение

// Appendix with status
#appendix-heading("справочное", level: 1)[Приложение с указанием статуса]

Текст приложения со статусом "справочное".
