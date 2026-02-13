= Default Styling in diatypst

== Terms, Code, Lists

_diatypst_ defines some default styling for elements, e.g Terms created with ```typc / Term: Definition``` will look like this

/ *Term*: Definition

A code block like this

```python
// Example Code
print("Hello World!")
```

Lists have their marker respect the `title-color`

#columns(2)[
  - A
    - AAA
      - B
  #colbreak()
  1. AAA
  2. BBB
  3. CCC
]



== Tables and Quotes



#columns(2)[
  Look at this styled table
  #table(
    columns: 3,
    [*Header*],[*Header*],[*Header*],
    [Cell],[Cell],[Cell],
    [Cell],[Cell],[Cell],
  )
  #colbreak()
  compared to an original one
  #table(
    stroke: 1pt,
    columns: 3,
    [*Header*],[*Header*],[*Header*],
    [Cell],[Cell],[Cell],
    [Cell],[Cell],[Cell],
  )
]

And here comes a quote

#quote(attribution: [Plato])[
  This is a quote
]

And finally, web links are styled like this: #link("https://typst.app")[typst.app]