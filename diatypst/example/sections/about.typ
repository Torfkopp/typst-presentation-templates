#import "../../util/colours.typ": *

= About

== General

_diatypst_ is a simple slide generator for _typst_.

#text(fill: title-colour)[
  The "buffed" version has some extra components and features I missed in Diatypst.
]

Features:

- easy delimiter for slides and sections (just use headings)
- sensible styling
- dot counter in upper right corner (like LaTeX beamer)
- adjustable color-theme
- default show rules for terms, code, lists, ... that match color-theme

This short presentation is a showcase of the features and options of _diatypst_.


== Usage

To start a presentation, initialize it in your typst document:

```typst
#import "@preview/diatypst:0.2.0": *
#show: slides.with(
  title: "Diatypst", // Required
  subtitle: "easy slides in typst",
  date: "01.07.2024",
  authors: ("John Doe"),
)
...
```

Then, insert your content.

- Level-one headings corresponds to new sections.
- Level-two headings corresponds to new slides.

== Options

To start a presentation, only the title key is needed, all else is optional!

Basic Content Options:
#table(
  columns: 3,
  [*Keyword*], [*Description*], [*Default*],
  [_title_], [Title of your Presentation, visible also in footer], [`none` (required!)],
  [_subtitle_], [Subtitle, also visible in footer], [`none`],
  [_date_], [a normal string presenting your date], [`none`],
  [_authors_], [either string or array of strings], [`none`],
  [_footer-title_], [custom text in the footer title (left)], [same as `title`],
  [_footer-subtitle_], [custom text in the footer subtitle (right)], [same as `subtitle`],
  [_logo_], [the logo to display at the title page and section slides], [`none`],
)

#pagebreak()

Advanced Styling Options:
#table(
  columns: 3,
  [*Keyword*], [*Description*], [*Default*],
  [_layout_], [one of _small, medium, large_, adjusts sizing of the elements on the slides], [`"medium"`],
  [_ratio_], [aspect ratio of the slides, e.g. 16/9], [`16/9`],
  [_title-color_], [Color to base the Elements of the Presentation on], [`blue.darken(50%)`],
  [_count_], [one of _dot, number, none_, adjusts the style of page counter in the right corner], [`"dot"`],
  [_footer_], [whether to display the footer at the bottom], [`true`],
  [_toc_], [whether to display the table of contents], [`true`],
  [_img-sources_], [whether to display the image sources at the end (see `util.image-link`) ], [`true`],
  [_theme_], [one of _normal, full_, adjusts the theme of the slide], [`"normal"`],
)

The full theme adds more styling to the slides, similar to a a full LaTeX beamer theme.