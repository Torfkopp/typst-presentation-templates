#import "util/components.typ"
#import "util/util.typ"
#import "util/colours.typ": *

#let layouts = (
  "small": ("height": 9cm, "space": 1.4cm),
  "medium": ("height": 10.5cm, "space": 1.6cm),
  "large": ("height": 12cm, "space": 1.8cm),
)

#let slides(
  content,
  title: none,
  subtitle: none,
  footer-title: none,
  footer-subtitle: none,
  date: none,
  university: none,
  authors: (),
  logo: none,
  layout: "medium",
  ratio: 16/9,
  count: "dot",
  footer: true,
  toc: true,
  img-sources: true,
  theme: "normal",
) = {

  // Parsing
  if layout not in layouts {
      panic("Unknown layout " + layout)
  }
  let (height, space) = layouts.at(layout)
  let width = ratio * height

  if count not in (none, "dot", "number") {
    panic("Unknown Count, valid counts are 'dot' and 'number', or none")
  }

  if theme not in ("normal", "full") {
      panic("Unknown Theme, valid themes are 'full' and 'normal'")
  }

  set text(fill: text-colour)

  // Setup
  set document(
    title: title,
    author: authors,
  )
  set heading(numbering: "1.")

  // PAGE----------------------------------------------
  set page(
    width: width,
    height: height,
    margin: (x: 0.5 * space, top: space, bottom: 0.6 * space),
    fill: background-colour,
    background: {
      align(top)[
        #block(width: 100%, height:0.9*space, fill: if theme == "full" {title-colour} else {background-colour})
      ]
    },
    // HEADER
    header: [
      #v(-0.5em)
      #components.header(count, theme, logo)
    ],
    header-ascent: 10%,
  // FOOTER
    footer: [
      #if footer == true {
        set text(0.7em)
        // coloured Style
        if (theme=="full") {
          components.full-footer(
            space, footer-title, footer-subtitle, title, authors,
            )
        }
        // Normal Styling of the Footer
        else if (theme == "normal") {
          components.normal-footer(
            footer-title, footer-subtitle, title, authors,
          )
        }
      }
    ],
    footer-descent:0.3*space,
  )

  // SLIDES STYLING--------------------------------------------------
  // Section Slides
  show heading.where(level: 1): x => {
    set page(header: none, footer: none, margin: 0cm)
    set align(horizon)
      grid(
        columns: (1fr, 3fr),
        inset: 10pt,
        align: (right,left),
        fill: (title-colour, white),
        [#block(height: 100%)[#if logo != none {image(logo)}]],
        [#text(1.2em, weight: "bold", fill: title-colour)[#x]]
      )

  }
  show heading.where(level: 2): pagebreak(weak: true) // this is where the magic happens
  show heading: set text(1.1em, fill: title-colour)


  // ADD. STYLING --------------------------------------------------
  // Terms
  show terms.item: it => {
    set block(width: 100%, inset: 5pt)
    stack(
      block(fill: header-colour, radius: (top: 0.2em, bottom: 0cm), strong(it.term)),
      block(fill: block-colour, radius: (top: 0cm, bottom: 0.2em), it.description),
    )
  }

  // Good looking topic arrow
  show sym.arrow.r.filled: set text(fill: title-colour)

  // Smaller Figure Captions
  show figure.caption: it => {
    set text(size: 8pt)
    it
  }

  // No numbers before headings
  show heading.where(level: 3):set heading(numbering: none)

  // Code
  show raw.where(block: false): it => {
    box(fill: block-colour, inset: 1pt, radius: 1pt, baseline: 1pt)[#text(size:8pt ,it)]
  }

  show raw.where(block: true): it => {
    block(radius: 0.5em, fill: block-colour,
          width: 100%, inset: 1em, it)
  }

  // Bullet List
  show list: set list(marker: (
    text(fill: title-colour)[•],
    text(fill: title-colour)[‣],
    text(fill: title-colour)[-],
  ))

  // Enum
  let colour_number(nrs) = text(fill:title-colour)[*#nrs.*]
  set enum(numbering: colour_number)

  // Table
  show table: set table(
    stroke: (x, y) => (
      x: none,
      bottom: 0.8pt+text-colour,
      top: if y == 0 {0.8pt+text-colour} else if y==1 {0.4pt+text-colour} else { 0pt },
    )
  )

  show table.cell.where(y: 0): set text(
    style: "normal", weight: "bold") // for first / header row

  set table.hline(stroke: 0.4pt+text-colour)
  set table.vline(stroke: 0.4pt)

  // Quote
  set quote(block: true)
  show quote.where(block: true): it => {
    v(-5pt)
    block(
      fill: block-colour, inset: 5pt, radius: 1pt,
      stroke: (left: 3pt+fill-colour), width: 100%,
      outset: (left:-5pt, right:-5pt, top: 5pt, bottom: 5pt)
      )[#it]
    v(-5pt)
  }

  // Link
  show link: it => {
    if type(it.dest) != str { // Local Links
      it
    }
    else {
      underline(stroke: 0.5pt+title-colour)[#it] // Web Links
    }
  }

  // Outline
  set outline(
    target: heading.where(level: 1),
    indent: auto,
  )
  show outline.entry.where(level: 1): it => {
      set align(horizon)
      set text(size: 1.4em)
      v(16pt, weak: true)
      (
        it.indented(
          strong(it.prefix()), 
          text(fill: title-colour, weight: "bold", it.body()) + 
          box(width: 1fr, it.fill) +
          strong(it.page())
        )
      )
    }
  show outline: set heading(level: 2) // To not make the TOC heading a section slide by itself

  // Bibliography
  set bibliography(
    title: none
  )
  show bibliography: it => {
    set text(size: 7pt)
    it
  }

  // Image Sources
  let image-sources = {
    context{
      let figures = query(figure)
      for f in figures{
        if not (repr(f.caption).contains(regex(util.https-site-regex))) {continue}
        if not f.has("label") {continue}
        ref(f.label) + ": " + link(repr(f.caption).find(regex(util.site-regex)))
        linebreak()
      } 
    }
  }


  // CONTENT---------------------------------------------
  // Title Slide
  if (title == none) {
    panic("A title is required")
  }
  else {
    if (type(authors) != array) {
      authors = (authors,)
    }
    set page(footer: none, header: none, margin: 0cm, background: none)
    block(
      inset: (x:0.5*space, y:1em),
      fill: title-colour,
      width: 100%,
      height: 60%,
      columns(2)[
        #align(bottom)[#text(2.0em, weight: "bold", fill: background-colour, title)]
        #if logo!= none {align(right)[#image(logo)] }
      ]
    )
    block(
      height: 30%,
      width: 100%,
      inset: (x:0.5*space,top:0cm, bottom: 1em),
      text(1.4em, fill: title-colour, weight: "bold", authors.join(", ", last: " & ")) +
    
      if subtitle != none { text(1.4em)[ \ ]  + [#subtitle]} +

      align(left+bottom)[
        #if date != none {date}
        #if date != none and university != none { [ \ ] }
        #if university != none { text(0.7em, university) }
      ] 
    )
  }
  counter(page).update(0)

  // Outline
  if toc {outline()}

  // Normal Content
  content

  if img-sources {
    heading(level: 2, "Image Sources")
    image-sources
  }
}