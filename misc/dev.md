# Development workflow

Typst: https://github.com/typst/typst#installation

To compile sources to pdf use:

```sh
typst compile src/main.typ article.pdf
```

To edit article in interactive way (typst updates `article.pdf` on any change):

```sh
typst watch src/main.typ article.pdf
```

## VS Code Setup

In VS Code plugin Tynimist can be used for integrated PDF preview and
PDF-to-sources navigation.

## Agentic development

The project contains `.agent` directory with Typst skill and GOST-specific
knowledge which can be used while markup creation.
