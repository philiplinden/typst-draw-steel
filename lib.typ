#let default_colors = (
  primary: rgb(40, 30, 20), // Dark brown for headers
  secondary: rgb(80, 60, 40), // Medium brown
  accent: rgb(120, 90, 60), // Lighter brown for accents
  text: black, // Black for body text
  bg: rgb(242, 235, 220), // Off-white paper
  border: rgb(100, 80, 60), // Border color
  table-header: rgb("#aaaaaa00"), // Header for tables
  table-row1: rgb(245, 242, 238), // Light background for tables
  table-row2: rgb("#aaffaa33"), // Dark background for tables
  quote-bg: rgb(240, 235, 228), // Quote background
)

#let footer-content = context {
  if here().page() > 1 {
    // place(left + bottom, none)
    // align(center)[#here().page()]
    align(right)[#counter(page).display()]
  }
}
#let footer = state("footer", footer-content)

#let draw-steel-license(your-item) = [
  #set par(spacing: 1.4em, first-line-indent: 0em, justify: true)
  #set text(size: 0.9em, style: "italic")
  #upper(your-item) is an independent product published under the DRAW STEEL Creator License and is not affiliated with MCDM Productions, LLC.
]

#let theme(
  font-size: 10pt,
  paper: "us-letter",
  justify: false,
  colors: default_colors,
  body,
) = {
  set par(spacing: 1.4em, first-line-indent: 0em, justify: justify)
  set text(size: font-size, lang: "en", fill: colors.text)
  set page(
    paper,
    flipped: false,
    margin: (left: 15mm, right: 15mm, top: 30mm, bottom: 30mm),
    columns: 2,
    background: none,
    footer: context {
      footer.get()
      footer.update(footer-content)
    },
  )

  show heading: it => block(text(
    size: 1.5em,
    fill: colors.primary,
    weight: "regular",
  )[
    #smallcaps(it.body)
  ])

  show heading.where(
    level: 2,
  ): it => block(text(
    size: 1.5em,
    fill: colors.primary,
    weight: "regular",
  )[
    #box(width: 100%, inset: (bottom: 4pt), stroke: (bottom: 1pt + colors.accent))[#smallcaps(it.body)]
  ])

  show heading.where(
    level: 4,
  ): it => block(text(
    size: 1.1em,
    fill: colors.primary,
    weight: "bold",
  )[
    #set par(spacing: .6em, first-line-indent: 1.5em)
    #smallcaps(it.body)
  ])

  body
}

#let chapter(
  title: "",
  break_at_end: true,
  content,
) = [
  #if title.len() > 0 {
    place(
      top + center,
      float: true,
      scope: "parent",
      clearance: 2em,
    )[
      = #title
    ]
  }
  // Render chapter content
  #content

  #if break_at_end { pagebreak() }
]

#let roll-table(title: "", byline: "", columns: (1fr, 4fr), align: (center, left), breakable: false, colors: default_colors, inset: 6pt, ..contents) = [
  #block(breakable: breakable)[
    #set par(spacing: .6em, first-line-indent: 1.5em)
    *#smallcaps(text(size: 1.3em)[#title])*\
    #text(style: "italic")[#byline]
    #line(length: 100%, stroke: 1pt + colors.border)
    #table(
      columns: columns,
      align: (col, row) => if col == 0 { align.at(0) } else { align.at(1) },
      fill: (col, row) => if calc.odd(row + 1) { colors.table-row1 } else { colors.table-row2 },
      inset: inset,
      stroke: none,
      ..contents
    )
  ]]


#let topfig(figure) = [ #place(top + center, dy: -7em, dx: 0em, float: true, scope: "parent", clearance: -6em, figure) ]
#let bottomfig(figure) = [ // Suppress the footer first
  #context footer.update("")
  #place(bottom + center, dy: 7em, dx: 0em, float: true, scope: "parent", clearance: -6em, figure)
]

#let breakoutbox(title, contents, bg-color: default_colors.quote-bg, border-color: default_colors.border) = [#place(auto, float: true)[
  #set par(first-line-indent: 0em, spacing: 0.6em)
  #box(inset: 10pt, width: 100%, stroke: (top: 2pt, bottom: 2pt), fill: bg-color)[
    #if title.len() > 0 {
      align(left, smallcaps[*#title*])
    }

    #align(left)[#contents]
  ]
]]

#let boxed-text(header, contents, bg-color: default_colors.quote-bg, border-color: default_colors.border) = [
  #box(
    inset: 10pt,
    fill: bg-color,
    stroke: (right: 1pt + border-color, left: 1pt + border-color),
    width: 100%,
  )[
    #set par(spacing: .6em, first-line-indent: 1.5em)
    #set text(size: 10pt)
    #heading(outlined: false, level: 3, header)
    #v(0.5em)
    #contents
  ]
]

#let characteristic(c, text-color: default_colors.bg, bg-color: default_colors.text, font: "arial", size: 0.8em) = {
    box(baseline: 0.2em, width: 1em, height: 1em, inset: 0pt, stroke: none, fill: bg-color)[
      #align(center + horizon)[
        #text(fill: text-color, weight: "bold", font: font, size: size)[#c]
      ]
    ]
}

#let might = characteristic("M")
#let reason = characteristic("R")
#let agility = characteristic("A")
#let presence = characteristic("P")
#let intuition = characteristic("I")

#let leq(x) = { "≤" + str(x) }
#let geq(x) = { "≥" + str(x) }
#let range(x, y) = { str(x) + "–" + str(y) }

#let ability(
  name: "",
  description: "",
  tags: (), // e.g. ("Melee", "Ranged", "Strike", "Weapon")
  action: "", // e.g. "Main action"
  target: "", // e.g. "One creature"
  distance: "", // e.g. "Melee 1"
  test: "", // e.g. "Power Roll + Might or Agility"
  tiers: (), // array of (threshold, text) pairs
  props: (), // array of (label, value) pairs, e.g. (("Effect", "something"))
  border-color: default_colors.border,
  pill-bg-color: default_colors.quote-bg,
  draw-pill: true,
) = [
  #set text(size: 10pt)
  #box(width: 100%, inset: (x: 1em, y: 0.5em))[
    // Title
    #set par(spacing: .6em, first-line-indent: 0em)
    *#smallcaps(name)*
    #if description.len() > 0 {
      set text(size: 0.9em)
      text(style: "italic")[#linebreak() #description]
    }

    // Divider
    #line(length: 100%, stroke: 1pt + border-color)

    // Roll
    #set text(size: 0.8em)
    #set par(spacing: 0.8em)
    #table(
      columns: (2fr, 1.5fr),
      align: (left, right),
      stroke: none,
      inset: 0pt,
      row-gutter: 0.5em,
      [#align(left)[
        #let tag_text = if type(tags) == array {
          if tags.len() > 0 { tags.join(", ") } else { "" }
        } else if tags == none {
          ""
        } else {
          str(tags)
        }
        #if tag_text != "" [*#tag_text*] else []
      ]],
      [#align(right)[#if action != "" [*#action*] else []]],

      [#align(left)[#if distance != "" [#text(size: 0.8em)[📐]#distance ] else []]],
      [#align(right)[#if target != "" [#text(size: 0.8em)[🎯]#target] else []]],
    )
    #v(0.5em)
    #block[
      #set par(spacing: 0.2em)
      #if test != "" [*#test*] else []
      #table(
        columns: (auto, auto),
        align: (center + horizon, left + horizon),
        stroke: none,
        inset: 0.5em,
        row-gutter: 0.0em,
        ..for (tier, damage) in tiers {
          (
            [
              #if draw-pill {
                box(
                  stroke: 0.5pt + border-color,
                  fill: pill-bg-color,
                  outset: 0.3em,
                  radius: 0.5em,
                )[
                #text(weight: "bold")[#tier]
              ]} else { text(weight: "bold")[#tier] }
            ],
            [#text(size: 1.1em)[#damage]],
          )
        }
      )
    ]
    #if props.len() > 0 {
      for (prop, value) in props [
        #par()[*#prop:* #value]
      ]
    }
  ]
]

#let kit(
  name: "",
  description: "",
  equpment: "",
  bonuses: (),
  signature-ability: (),
) = [
  === #name
  #description
  ==== Equipment
  #equpment
  ==== Kit Bonuses
  #for (kind, bonus) in bonuses [
    *#kind:* #bonus\
  ]
  ==== Signature Ability
  #signature-ability
]
