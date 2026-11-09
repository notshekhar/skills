# Hand-drawn SVG diagrams

Diagrams are inline SVG written by hand, styled only by the classes in
`assets/template.html`. No Mermaid, no chart library, no images. Hand-placed
SVG is what makes these pages look designed instead of generated.

## When to draw

Draw when the content has a shape: an architecture (parts + what calls what),
a flow with branches or loops, a pipeline, a before/after, a timeline, items on
two axes, a funnel. A straight list of steps stays an `<ol>`. Items compared on
several attributes stay a `<table>`.

## Frame

- `viewBox="0 0 760 H"`. Width is always 760; the page scales it to the column.
  A picture that needs room grows **down**, never wider.
- H = bottom of the lowest element + 24.
- Left margin 24, right edge of content at most 736.
- `role="img"` and `aria-label` = the title's words.

## Title

The first `<text class="t">` at `x=24 y=28..32` states the **finding**, not the
topic: "Every case feeds back into the next one", not "Case flow".

## Boxes

| element | class | size |
| --- | --- | --- |
| normal box | `box` | `rx="8"` |
| the one box that matters | `hot` | use once per drawing |
| a warning or risk box | `warmbox` | rarely |
| container around boxes | `hot` or `box` | name line at top + 32, children 16 in from each side and 16 above its foot |

- A box with a name + n body lines is `40 + 16n` tall. Name baseline at
  `top + 24`, first body line at `top + 40` (left-aligned) or `top + 42`
  (centred under a centred name), each next line +16.
- Names: `class="n"` (13px, 600). Body lines: `class="q"` (11.5px, muted).
- Centred text: add `mid` and put `x` at the box's centre.

**SVG does not wrap. Count characters before you write.** Width per character:

| text | units per char |
| --- | --- |
| title 15/600 | 8.5 |
| name 13/600 | 7.4 |
| body 11.5 | 6.2 |

A line fits if `chars × units ≤ box width − 24`. A 154-wide box holds 17 name
characters and 21 body characters. A 224 box: 27 / 32. A 340 box: 42 / 50.
Too long → shorten the words or widen the box, never let text touch a border.

## Grid that always works

- Four columns: boxes `x = 24, 210, 396, 582`, width 154, centres
  `101, 287, 473, 659`.
- Three columns: `x = 24, 268, 512`, width 224.
- Two columns: `x = 24, 396`, width 340.
- Rows of 56-tall boxes every 104 units (`64, 168, 272, 376`) leave a 48 gap
  for arrows and labels.

## Connectors

- Put connectors in `<g class="wire">`; each `<path>` gets
  `marker-end="url(#arrow)"` (two-way: add `marker-start` too).
- One `<marker id="arrow">` per SVG (ids must be unique in the page: use
  `arrow`, `arrow2`, … when there are several drawings).
- Start and end **on a box edge**. Run in the gaps, never across a box.
- Fan out: down from the parent to a horizontal bus, then down to each child
  (`M659 120V144H101V168` + `M287 144V168` …).
- Fan in: the same bus, below the children, with one arrow down to the target.
- A loop back (feedback, retry) goes around the outside: down, sideways to
  `x=12` or `x=748`, along, and back in. Make the important loop `class="loop"`
  with its own accent arrowhead (`<path class="arrowhead hot" …>`).
- Edge labels: `class="q"`, 8 units right of a vertical line or 8 above a
  horizontal one, never on the line.

## Colour

Only the classes. The accent (`hot`, `loop`) appears once or twice per
drawing, on the thing the title is about. Five highlighted boxes = none.

## Bar chart (when a few numbers need comparing)

Horizontal bars, one row per item, label left, value right:

```
<text class="n" x="24" y="72">Item</text>
<rect class="bar" x="200" y="60" width="{value / max * 480}" height="16" rx="3"/>
<text class="q" x="{200 + width + 8}" y="72">{value}</text>
```

Rows every 32 units. Compute widths with real numbers before writing; never
eyeball them.
