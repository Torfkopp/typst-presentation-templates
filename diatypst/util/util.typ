#import "colours.typ": *

#let site-regex = "[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)"
#let https-site-regex = "https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)"

#let last-slide-counter = counter("last-slide")
#let first-slide-counter = counter("first-slide")

// Call this methdo at your last regular slide
#let update-last-slide-counter() = {
  context last-slide-counter.update(counter(page).get().first())
}

// Gets the number of the last slide of the presentation
#let get-last-slide-counter() = {
  let c = last-slide-counter.final().first()
  if c == 0 {c = counter(page).final().first()}
  c
}

// Highlights the text in the title colour
#let highlight(it) = {
  set text(fill: title-colour)
  set text(weight: "bold")
  it
}

// Adds a hyperlink to the image description and adds the link to the image sources
#let image-link(it) = {
  link(it)[\*] //#context counter(figure).display("a")]]
}

// Displays the source at the bottom right corner
#let source(it) = {
  v(1fr)
  set align(bottom+right)
  it
}
