#import "@preview/catppuccin:1.0.1": flavors, get-flavor
#let flavour = get-flavor("mocha")
#let palette = flavour.colors

// accent colours
#let accent = palette.green.rgb

// background colours
#let base = palette.base.rgb
#let base-muted = palette.mantle.rgb

// text colours
#let text-colour = palette.text.rgb
#let text-subtext = palette.subtext1.rgb

// functional colours
#let alert = palette.red.rgb
#let example = palette.blue.rgb

#let light = (

)

#let dark = (

)

#let make-gradients() = {

}