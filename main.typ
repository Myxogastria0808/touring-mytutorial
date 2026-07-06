// for slide show
#import "@preview/touying:0.7.4": *
// slide theme
#import themes.simple: *
// for numbering slides
#import "@preview/numbly:0.1.0": numbly

// set slide numbering style
#set heading(numbering: numbly("{1}.", default: "1.1"))
// aspects ratio for slides, default is 16:9
#show: simple-theme.with(
  aspect-ratio: "16-9",
  // set handout mode for printing, default is false
  // you can select the sub slides where you want to show in handout mode
  // e.g.
  // ```
  // // Keep only the first subslide (useful for "before" snapshots)
  // config-common(handout: true, handout-subslides: 1)
  // Keep the first and last subslides
  // config-common(handout: true, handout-subslides: (1, -1))
  // // Keep a range expressed as a string (same syntax as `only`/`uncover`)
  // config-common(handout: true, handout-subslides: "1-2")
  // ```
  // cf. https://touying-typ.github.io/docs/tutorials/dynamic/handout
  config-common(handout: false),
  header: [
    // show current section (level: 1) in the header
    #text(gray, utils.display-current-heading(level: 1)),
    \
    // show current subsection (level: 2) in the header
    #text(gray, utils.display-current-heading(level: 2))
  ],
  // show current slide number and total slide count in the footer
  // cf. https://touying-typ.github.io/docs/tutorials/progress/counters
  footer-right: context [#utils.slide-counter.get().first() - #utils.last-slide-number],
  // show progress bar in the footer
  // cf. https://touying-typ.github.io/docs/tutorials/progress/counters#progress-bar
  footer: self => utils.touying-progress(ratio => {
    // ratio is a float between 0.0 and 1.0
    box(width: ratio * 100%, height: 4pt, fill: self.colors.primary)
  }),
)

= Title

== Table of Contents

// show table of contents
// cf. https://touying-typ.github.io/docs/tutorials/sections#table-of-contents
#components.adaptive-columns(outline(title: none, indent: 1em))

== Simple Slide

Hello, World!

== Page columnization

// simpla pattern
// cf. https://touying-typ.github.io/docs/tutorials/layout#page-columnization
#slide[
  First column.
][
  Second column.
]

// chnage separate ratio
// cf. https://touying-typ.github.io/docs/tutorials/layout#page-columnization
// you ca modify the `composer` parameter of `slide`
#slide(composer: (1fr, auto))[
  First column
][
  Second column
]

== Preventing Content Overflow
// cf. https://touying-typ.github.io/docs/tutorials/layout#preventing-content-overflow

// When the content of a slide is too long, it may overflow the slide area.
// To prevent this, Touying sets `config-common(breakable: false)` by default.
// This config prevent overflow, panic on overflow.
// Prevent overflow, panic on overflow (default behavior when breakable: false)
#show: touying-set-config.with(
  config-common(breakable: false),
)

== Preventing Content Overflow (clip)
// cf. https://touying-typ.github.io/docs/tutorials/layout#preventing-content-overflow

// Prevent overflow and visually clip overflowing content
// clip only take effects when breakable: false
#show: touying-set-config.with(
  config-common(breakable: false, clip: true),
)

// show 500 words of lorem ipsum text to demonstrate the overflow behavior
#lorem(500)

== Simple Animation (pause)

First show message!

// pause animation effect
#pause

Second show message!

== Simple Animation (pause + meanwhile)

Fist show message!

#pause

Second show message!

// show additional message simultaneously with `#pause`
#meanwhile

Third show message!

#pause

Fourth show message!

== Complex Animation Pattern 1 (uncover, only, alternatives)

// repeat: set animation step explicitly
#slide(repeat: 3, self => [
  #let (uncover, only, alternatives) = utils.methods(self)

  At subslide #self.subslide, we can

  // #uncover("show animation step")[`contents`]
  use #uncover("2-3")[`#uncover` function] for reserving space,

  // #only("show animation step")[`contents`]
  use #only("2-3")[`#only` function] for not reserving space,

  // #alternatives[`the forst step contents`][`the second step contents`][`the third step contents`] ...
  #alternatives[call `#only` multiple times \u{2717}][use `#alternatives` function #sym.checkmark] for choosing one of the alternatives.
])

== Complex Animation Pattern 2 (uncover, only, alternatives)

// repeat: set animation step explicitly
#slide(repeat: 3, self => [
  #let (uncover, only, alternatives) = utils.methods(self)

  #alternatives[Ann][Bob][Christopher]
  likes
  #alternatives[chocolate][strawberry][vanilla]
  ice cream.
])

== Math Equation Simple Animation (pause, meanwhile)

#slide[
  Touying equation with pause:

  $
    f(x) & = pause x^2 + 2x + 1 \
         & = pause (x + 1)^2 \
  $

  #meanwhile

  Touying equation with meanwhile:

  $
    F & = meanwhile m a \
  $

  #meanwhile

  Touring equation is very simple
]


== Math Equation Complex Animation (uncover, only, alternatives)

#slide(repeat: 3, self => [
  #let (uncover, only, alternatives) = utils.methods(self)

  $
    f(x) & = only("2-", x^2 + 2x +) uncover("3-", 1) \
         & = only("3-", (x + 1)^2) \
  $
])

// show appendix
// slide counter is frozen here, so following slides don't affect
// the total slide count shown in the footer
// c.f. https://touying-typ.github.io/docs/tutorials/sections#appendix
#show: appendix

== Extra Notes for Handout <touying:handout>
// cf. https://touying-typ.github.io/docs/tutorials/dynamic/handout#handout-only-slides

// <touying:handout>
// This slide is included when `handout: true` but invisible otherwise.

Hello, houdout mode!

