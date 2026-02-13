#import "@preview/catppuccin:1.0.1": flavors, get-flavor
#let flavor = get-flavor("mocha")
#let palette = flavor.colors

#let title-colour = palette.green.rgb

#let background-colour = palette.base.rgb
#let text-colour = palette.text.rgb

#let block-colour = palette.crust.rgb
#let body-colour = text-colour
#let header-colour = title-colour.lighten(65%)
#let fill-colour = title-colour.darken(60%)
