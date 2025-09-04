# Typst Draw Steel template

This is a [Typst](https://typst.app) template for Draw Steel content, forked from the D&D 5e template
[dragonling](https://github.com/coljac/typst-dnd5e) by Colin Jacobs.

## Install / import

- From the Typst preview registry:

```typst
#import "@preview/scabbard:0.1.0": *
```

- Or locally during development:

```typst
#import "./lib.typ": *
```

See a complete usage sample in `example/example.typ`.

## Usage overview

These are the primary helpers exposed by `lib.typ`.

- `theme` Sets page, text, headings, footer. Wrap document with `#show: theme.with(...)`.

- `chapter` Renders a chapter title at top of page and optional pagebreak at end.

- `roll-table` Two-column (or custom) table with zebra rows and header. See examples below.

- `ability` Modular action/ability block. `tiers` is an array of (threshold, content) pairs. `tags` accepts a string or an array; a single string is handled correctly.

- `kit` Kit card with sections and a signature `ability(...)`.

- `boxed-text` Full-width callout box.

- `breakoutbox` Floating callout box.

- `agility`, `reason`, `intuition`, `presence` (inline glyphs) and comparators `leq(x)`, `geq(x)`, `range(x, y)`.

- `topfig` Place full-width figures at top (bottom suppresses footer for that page).

- `bottomfig` Place full-width figures at bottom (bottom suppresses footer for that page).

- `draw-steel-license(your-item)` License footer snippet for your product name.

### Minimal document

```typst
#import "@preview/scabbard:0.1.0": *

#show: theme.with(paper: "us-letter")
#set document(author: "Your Name", title: "Your Title")

#chapter(title: "Table of Contents", [
  #set text(size: 10pt)
  #outline(title: none, depth: 3)
])
```

### Roll tables

```typst
#roll-table(
  title: "Emotions",
  byline: "My emotions are unregulated, let's roll the dice.",
  columns: (1fr, 4fr),
  align: (center, left),
  breakable: false,
    [#leq(2)], [Happy],
    [#range(3, 5)], [Tired],
    [6], [Confused],
    [7], [Bored],
    [#geq(8)], [Happy],
)
```

### Ability block

```typst
#ability(
  name: "Exploding Arrow",
  description: "Your ammunition explodes with magical energy.",
  tags: ("Magic", "Ranged", "Strike", "Weapon"),
  action: "Main action",
  target: "One creature",
  distance: "Ranged 15",
  test: "Power Roll + Agility, Reason, Intuition, or Presence",
  tiers: (
    (leq(11), [ 5 + #agility, #reason, #intuition, or #presence fire damage ]),
    (range(12, 16), [ 7 + #agility, #reason, #intuition, or #presence fire damage ]),
    (geq(17), [ 10 + #agility, #reason, #intuition, or #presence fire damage ]),
  ),
  props: (("Effect", [One creature within 2 squares takes fire damage equal to the characteristic score used for the power roll.])),
)
```

## Page-wide images and tables

There are two helper functions included with the template, `topfig` and `bottomfig`. This code:

```typst
#bottomfig(image("swordtorn.png", width=140%))
```

will insert the image at the bottom of the page, spanning both columns like so, and will suppress the footer for that page.

## Acknowledgements

Forked from [dragonling](https://github.com/coljac/typst-dnd5e) by Colin Jacobs
based on [Draw Steel](https://shop.mcdmproductions.com/collections/draw-steel)
by MCDM Productions.

This template is an independent product published under the DRAW STEEL Creator License and is not affiliated with MCDM Productions, LLC.
