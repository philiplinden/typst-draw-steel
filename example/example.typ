// #import "@preview/scabbard:0.1.0": *
#import "../lib.typ": *
#import "cover.typ": cover-page

#show: theme.with(paper: "us-letter")
#set document(author: "Philip Linden", title: "Scabbard") // set doc metadata

#cover-page(
  title: "Scabbard",
  subtitle: "A template for creating Draw Steel content",
  author: "Philip Linden",
)

#chapter(title: "Table of Content", [
  #set text(size: 10pt)
  #outline(title: none, depth: 3)
])

#chapter(title: "An Example", [
  == Hello from the Example

  You can embed characteristic symbols like #agility, #reason, #intuition, or #presence directly in the text. Comparators like #leq(10) or #geq(10) are also available, as are ranges like #range(1, 10).

  #lorem(100)
  
  === How are you?
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

  It's totally cool to abuse the macros!

  #roll-table(
  title: "Fury",
  byline: "Primal warrior channeling chaotic rage",
  columns: (auto, 1fr),
  [*Best for*],
  [Berserkers, beast clan warriors, primal fighters, corruption-touched barbarians],
  [*Resource*],
  [Rage (building ferocity and primordial chaos)],
  [*Focus*],
  [High mobility, devastating attacks, battlefield destruction, primal transformation],
)

  == Modular Macros
  
  #ability(
    name: "This is really something",
    description: "I didn't expect to see anything!",
    tags: ("Strike"),
    action: "Main action",
    target: "Everyone in the universe",
    distance: "Melee 1",
    test: "Power Roll + Agility, Reason, Intuition, or Presence",
    tiers: (
      (1, [
        5 + #agility, #reason, #intuition, or #presence fire damage
      ]),
      (geq(1000), [
        arbitrary text
      ]),
    ),
    props: (
      (
        "Effect",
        lorem(25),
      ),
      (
        "Another one",
        lorem(25),
      ),
    ),
  )

  #kit(
  name: "Arcane Archer",
  description: [The Arcane Archer kit allows you to combine magic and ranged
    weapon strikes. Your lack of armor keeps you mobile, and your magic
    makes your arrows explode to devastate your foes.],
  equipment: [You wear no armor and wield a bow.],
  bonuses: (
    ("Speed", "+1"),
    ("Ranged Damage", "+2/+2/+2"),
    ("Ranged Distance", "+10"),
    ("Disengage", "+1"),
  ),
  signature-ability: ability(
    name: "Exploding Arrow",
    description: "Your ammunition explodes with magical energy.",
    tags: ("Magic", "Ranged", "Strike", "Weapon"),
    action: "Main action",
    target: "One creature",
    distance: "Ranged 15",
    test: "Power Roll + Agility, Reason, Intuition, or Presence",
    tiers: (
      (leq(11), [
        5 + #agility, #reason, #intuition, or #presence fire damage
      ]),
      (range(12, 16), [
        7 + #agility, #reason, #intuition, or #presence fire damage
      ]),
      (geq(17), [
        10 + #agility, #reason, #intuition, or #presence fire damage
      ]),
    ),
    props: (
      (
        "Effect",
        "One creature or object of your choice within 2 squares of the target takes fire damage equal to the characteristic score used for this ability’s power roll.",
      ),
    ),
  ),
)
])

#chapter(title: "Don't forget the license!", break_at_end: false, [
  #boxed-text("License", [
    #draw-steel-license("example")
  ])
  #breakoutbox("License", [
    #draw-steel-license("example")
  ])
])
