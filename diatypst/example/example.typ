
#import "../lib.typ": *
#import "../util/util.typ": *

#show: slides.with(
  title: "Buffed Diatypst", // Required
  subtitle: "Diatypst with some extra features",
  date: datetime.today().display(),
  authors: ("Name Lastname", "Vorname Nachname"),
  university: "Universityname",
  footer-title: "This is a footer title",
  footer-subtitle: "Footer Subtitle",
  logo: "/example/images/logo.png",
  // Optional Styling
  ratio: 16/9,
  layout: "medium",
  toc: true,
  img-sources: true,
  footer: true,
  count: "number",
  theme: "normal",
)

#include "sections/about.typ"
#include "sections/styling.typ"
#include "sections/buffed.typ"

== Bibliography
#bibliography("refs.bib")
