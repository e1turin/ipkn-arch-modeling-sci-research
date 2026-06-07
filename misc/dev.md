# Development workflow

Typst: https://typst.app
Ninja: https://ninja-build.org/

## Commands

```sh
ninja           # compile article.pdf (default)
ninja article   # compile article.pdf
ninja dev       # start watching (auto-rebuild on save)
```

## Project structure

```
├── build.ninja                  # Ninja build file
├── src/
│   ├── main.typ                 # Entry point — document setup + chapter includes
│   ├── chapters/
│   │   ├── 010-introduction.typ  # Введение
│   │   ├── 020-main-content.typ  # Основное содержание, элементы, аргументы
│   │   ├── 030-conclusion.typ    # Заключение
│   │   └── 040-appendices.typ    # Приложения
│   ├── figures/                 # Изображения и иллюстрации
│   └── refs/
│       └── references.bib       # Библиографические ссылки
├── article.pdf                  # Скомпилированный отчёт
├── misc/
│   └── dev.md                   # Этот файл
└── README.md
```

## VS Code Setup

In VS Code plugin Tinymist can be used for integrated PDF preview and
PDF-to-sources navigation.

## Agentic development

The project contains `.agents` directory with Typst skill and GOST-specific
knowledge which can be used while markup creation.
