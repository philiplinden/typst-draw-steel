# Typst Draw Steel template

This is a [Typst](https://typst.app) template for Draw Steel content forked from
the Dungeons & Dragons 5e typst template
[dragonling](https://github.com/coljac/typst-dnd5e) by Colin Jacobs.

The template is called "scabbard" and can be imported as:
`#import "@preview/scabbard:0.1.0": *`

## Basic usage

The `dndmodule` template sets up your document for you. The arguments you may want to specify up front are as follows:

- `title`: The document's title, this will be rendered as text. Omit if you already have cover art with the title.
- `subtitle`: A slug line for down the bottom of the front cover.
- `author`: Your name.
- `cover`: An `image` to use on the front cover
- `fancy-author`: This will put the author's name in that red flame thingy that D&D books tend to have.
- `logo`: Supply an `image` to put the logo on the front page.
- `font-size`: Defaults to `12pt`.
- `paper`: Defaults (sensibly) to `a4` (Americans, you might want `us-letter`).
- `add-title`: (bool) Whether to print the title on the front page. Set to false if you've made your own image, for instance.

From there, just about everything you need can be done with basic Typst markup. Some convenience functions are provided in the template:

`dnd`: Prints "Dungeons & Dragons" in small caps, as required per the official style guide.

`dndtab(name, columns: (1fr, 4fr), breakable: false, ..contents)`: A table with the conventional formatting. Defaults to 2 columns with ratio 1:4 as shown; if `breakable` is `true`, can be split over multiple pages.

`breakoutbox(title, contents)`: Inserts a box with coloured background, and the optional title in small caps.

`statbox(stats)`: Accepts a dictionary with the following format. The `skillblock` and `traits` can contain arbitrary keys. After the traits, any of "Actions", "Reactions", "Limited Usage", "Equipment", or "Legendary Actions" will be subsequently shown if present.

```typst
#statbox((
  name: "Creature name",
  description: [Size creature, alignment],
  ac: [20 (natural armor)],
  hp: [29 (1d10 + 33)],
  speed: [10ft, climb 10ft.],
  stats: (STR: 13, DEX: 14, CON: 18, INT: 5, WIS: 4, CHA: 7),  // Modifiers will be auto-calculated
  skillblock: (
      Skills: [Perception +6, Stealth +5],
      Senses: [passive Perception 13],
      Languages: [Gnomish],
      Challenge: [5 (1800 XP)]
  ),
  traits: (
    ("Trait name", [Trait desription]),
    // ..
    ("Trait name", [Trait desription])
),
  Actions: (
    ("Multiattack", [While the monster remains alive, it is a thorn in the party's side.]),
    ("Saliva", [If a character is eaten by the monster, it takes 1d10 saliva damage per round.]),
    ("Tentacle squeeze", [If the monster has captured an enemy, it can squeeze them for 1d12 crushing damage.])
  )
))
```

`spell`: Accepts a dictionary as follows; the properties are all optional:

```typst
#spell((
  name: "",
  spell-type: [2nd level ...],
  properties: (
    ("Casting time", []),
    ("Range", []),
    ("Duration", []),
    ("Components", []),
  ),
  description: [Spell effects description]
  )
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
