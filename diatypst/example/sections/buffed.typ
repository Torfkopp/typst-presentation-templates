#import "../../util/util.typ": *

= Buffed

== What's Buffed?

=== Looks
+ Navigation Bar at the Top
+ Progress Bar in "normal" theme
+ Different outline
+ Some minor things like smaller font size in bibliography
+ Colours are settable in the `colours.typ` file

#pagebreak()
=== Workings
#columns(2)[
  #[
    + Source method to show one or multiple sources at the bottom right 
    + Image-link method to add a hyperlink and create an entry in the image sources slide
    + Method to #highlight[Highlight stuff] in the main colour
    + Slide-counter may end at the user designated last slide (use `update-last-slide-counter()` at it)
  ]
  #colbreak()
  #figure(
    image("../images/rick.png", height: 80%),
    caption: [Rick Astley #image-link("https://upload.wikimedia.org/wikipedia/it/f/f0/Screenshot_Videoclip_Never_Gonna_Give_You_Up.png")]
  ) <Rick>
  #source[@astley1987]
]

= Arrows
#update-last-slide-counter()

Selection of arrows to the right because the ones typst offers may look bad 

#text(fill: title-colour)[
  Typst: \ #sym.arrow #sym.arrow.r.filled \ \
  Others: \ →
  ➡
  ⮕
  ⇨
  ➙ \
  ➛ ➜ ➔ ➝ ➞ ➟ ➠ ➧ ➨  \ ➺ ➻ ➼ ➽ \
  🠊 🠢 🠊 🠆 🠪 🠮 🠲 🠞 🠚 🢂 🡺 🡲 🡆 
]

#text(size: 4em, fill: title-colour)[¯\\_(ツ)_/¯]