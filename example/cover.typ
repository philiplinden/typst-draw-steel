#let cover-page(
  title: "",
  author: "",
  subtitle: "",
) = {
  set document(author: author, title: title) // set doc metadata
  page(
    fill: blue,
    margin: (top: 10mm, bottom: 5mm),
    columns: 1,
  )[
    #if title.len() > 0 {
      set par(leading: 0.1em) // tighten/loosen vertical line spacing
      place(
        top + center,
        box(fill: rgb("#00000088"), inset: 5%, outset: 5%,
        text(
          fill: white,
          size: 60pt,
          weight: 800,
          upper(title)
        )),
      )
    }
    
    #if author.len() > 0 {
      place(
        top + right,
        dy: 13%)[
        #text(size: 18pt, fill: white, weight: 700)[by #author]
      ]
    }

    #if subtitle.len() > 0 {
      place(
        bottom + center,
        dy: -0.2cm,
        box(width: 100%, fill: rgb("#00000088"), inset: (left: 10pt, right: 10pt, top: 10pt, bottom: 10pt), text(
          fill: white,
          size: 28pt,
        )[#subtitle]),
      )
    }
  ]
}
