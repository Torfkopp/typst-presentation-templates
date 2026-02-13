#import "util.typ"
#import "colours.typ": *

#let progress-bar(height: 2pt, primary, secondary) = {
  context {
    let last = util.get-last-slide-counter()
    let current = counter(page).get().first()
    let ratio = current / calc.max(1.0, last)
    // ratio = calc.min(1.0, ratio) if progress should stay full
    if ratio <= 1.0{
      grid(
        columns: (ratio * 100%, 1fr),
        rows: height,
        gutter: 0pt,
        grid.cell(fill: primary)[], grid.cell(fill: secondary)[],
      )
    } else {
      let overshoot = (current - last) / (counter(page).final().last() - last)
      grid(
        columns: (overshoot * 100%, 1fr),
        rows: height,
        gutter: 0pt,
        grid.cell(fill: black)[], grid.cell(fill: primary)[],
      )
    }
  }
}

#let short-heading-func(self: none, it) = {
  if it == none {
    return
  }
  let convert-label-to-short-heading = if (
    type(self) == dictionary and "methods" in self and "convert-label-to-short-heading" in self.methods
  ) {
    self.methods.convert-label-to-short-heading
  } else {
    (self: none, lbl) => titlecase(lbl.replace(regex("^[^:]*:"), "").replace("_", " ").replace("-", " "))
  }
  convert-label-to-short-heading = convert-label-to-short-heading.with(self: self)
  assert(type(it) == content and it.func() == heading, message: "it must be a heading")
  if not it.has("label") {
    return it.body
  }
  let lbl = str(it.label)
  return convert-label-to-short-heading(lbl)
}

#let simple-navigation(
  self: none,
  short-heading: true,
  primary: white,
  secondary: gray,
) = (
  context {
    let body() = {
      let sections = query(heading.where(level: 1))
      if sections.len() == 0 {
        return
      }
      let current-page = here().page()
      set text(size: 0.7em, weight: "bold")
      for (section, next-section) in sections.zip(sections.slice(1) + (none,)) {
        set text(fill: if section.location().page() <= current-page and (
          next-section == none or current-page < next-section.location().page()
        ) {
          primary
        } else {
          secondary
        })
        box(inset: 0.5em)[#link(
            section.location(),
            if short-heading {
              short-heading-func(self: self, section)
            } else {
              section.body
            },
          )]
      }
    }
    block(
      // fill: background,
      inset: 0pt,
      outset: 0pt,
      grid(
        align: center + horizon,
        columns: (1fr, auto),
        rows: 1.8em,
        gutter: 0em,
        grid.cell(
          body(),
        ),
      ),
    )
  }
)

#let page-counter(type, fill-color, text-colour) = {
  if type == "dot" {
    set align(right + top)
    context {
      let last = counter(page).final().first()
      let current = here().page()
      // Before the current page
      for i in range(1,current) {
        link((page:i, x:0pt,y:0pt))[
          #box(circle(radius: 0.08cm, fill: fill-color, stroke: 1pt+fill-color))
        ]
      }
      // Current Page
      link((page:current, x:0pt,y:0pt))[
          #box(circle(radius: 0.08cm, fill: fill-color, stroke: 1pt+fill-color))
        ]
      // After the current page
      for i in range(current+1,last+1) {
        link((page:i, x:0pt,y:0pt))[
          #box(circle(radius: 0.08cm, stroke: 1pt+fill-color))
        ]
      }
    }
  } else if type == "number" {
    set align(right + top)
    context {
      //let last = counter(page).final().first()
      // let last = util.last-slide-counter.final().first()
      let last = util.get-last-slide-counter()
      // let current = here().page()
      let current = counter(page).get().first()
      set text(weight: "bold")
      set text(fill: text-colour)
      [#current / #last]
    }
  }
}

#let header(count, theme, logo) = {
  let primary = if theme == "normal" {title-colour} else {background-colour}
  let secondary = fill-colour
  box(height: 100%)[
    #stack(
      dir: ttb,
      align(top + center)[#box()[
        #simple-navigation(primary: primary, secondary: secondary)
      ]],
      align(top)[
        #columns(2)[
          #context {
            let page = here().page()
            let headings = query(selector(heading.where(level: 2)))
            let heading = headings.rev().find(x => x.location().page() <= page)

            if heading != none {
              set align(top)
              set text(1.4em, weight: "bold", fill: primary)
              smallcaps[#heading.body]
              if not heading.location().page() == page [
                #{numbering("(i)", page - heading.location().page() + 1)}
              ]
            }
          }
          #colbreak()
          #align(top + right)[#page-counter(count, secondary, primary)]
        ]
      ]
    )
  ]
}

#let full-footer(space, footer-title, footer-subtitle, title, authors) = {
  columns(2, gutter:0cm)[
    // Left side of the Footer
    #align(left)[#block(
      width: 100%,
      outset: (left:0.5*space, bottom: 0cm),
      height: 0.3*space,
      fill: fill-colour,
      inset: (right:3pt)
    )[
      #v(0.1*space)
      #set align(right)
      #smallcaps()[#if footer-title != none {footer-title} else {title}]
      ]
    ]
    // Right Side of the Footer
    #align(right)[#block(
      width: 100%,
      outset: (right:0.5*space, bottom: 0cm),
      height: 0.3*space,
      fill: body-colour,
      inset: (left: 3pt)
    )[
      #v(0.1*space)
      #set align(left)
      #if authors != none {
          if (type(authors) != array) {authors = (authors,)}
          authors.join(", ", last: " and ")
      } else if footer-subtitle != none {
          footer-subtitle
      } else if subtitle != none {
          subtitle
      } else [#date]
    ]
  ]
  ]
}

#let normal-footer(footer-title, footer-subtitle, title, authors) = {
  progress-bar(height: 2pt, title-colour, body-colour) 
  v(-0.25cm)
  block(
    width: 100%
  )[
    #grid(
      columns: (auto, 1fr),
      align: (left, right),
      [#if footer-title != none {footer-title + if footer-subtitle != none {" - " + footer-subtitle} else {}} else {title}],
      [
        #if authors != none {
          if (type(authors) != array) {authors = (authors,)}
          authors.join(", ", last: " and ")
        } else if footer-subtitle != none {
            footer-subtitle
        } else if subtitle != none {
            subtitle
        } else [#date]
      ]
    )
  ]
}
