---
name: html-reports
description: Write a design doc, report, explainer, research summary, postmortem, comparison or plan as one self-contained HTML file in a calm, editorial style — dark by default with an automatic light theme, system fonts, a single 900px column, hairline tables, stat rows, callouts and hand-drawn inline SVG diagrams (architecture, flows, loops, pipelines, bar charts). Use whenever the user asks for an HTML doc, an HTML report, "make a page", "write this up as html", "put it in the docs folder", a local explainer or a shareable write-up as a file — even if they don't say "design" or "diagram".
---

# HTML reports

One `.html` file, no dependencies, opens from disk. The look is already designed
in `assets/template.html`; your job is clear writing and correct diagrams, not
inventing a new style.

## Workflow

1. **Know the answer first.** Write the lede (2–3 sentences: what this is, the
   result, the one number or decision) before anything else. If you can't, you
   aren't ready to write the page.
2. **Copy the template** to the target path (ask where only if no folder is
   obvious; a `docs/` folder in the project is the usual home). Keep the whole
   `<style>` block as is. Delete the components you don't use.
3. **Outline as `<h2>` sections**, each with an `id`, and list them in `<nav>`.
   Order: what it is → how it works (diagram) → details → plan → open questions.
4. **Pick the form for each piece of content** (table below), then write.
5. **Draw diagrams by hand** — read `references/diagrams.md` before the first
   one. Count characters against box widths before writing each label.
6. **Look at it.** Run `scripts/shot.sh <page> <out.png>` and view the PNG.
   Fix text overflowing boxes, arrows through labels, crowded spots. Check the
   whole page, not just the top: raise the height argument for long pages.
   Never say it looks right without looking.

## Which form

| content | form |
| --- | --- |
| a straight sequence of steps | `<ol>` with a bold lead-in per item |
| parallel points | `<ul>`, each item starting with a **bold phrase.** |
| items × attributes (options, roles, phases, costs) | `<table>`, units in headers, `class="num"` on number columns |
| 2–4 headline numbers | `.stats` row |
| one thing the reader must not miss | `.note` (decision) or `.warn` (risk), one per section at most |
| parts and what calls what, a flow with branches/loops, a pipeline | inline SVG diagram |
| a few numbers to compare | SVG bar chart (see diagrams reference) |
| config, code, payloads, folder layouts | `<pre><code>` (escape `<`, `>`, `&`) |
| open questions, next steps | `<ul class="todo">` |
| long optional detail | `<details><summary>` |

## Writing rules

- **First sentence of the page and of every section is the point** — the
  decision, result or answer, with its number. Never "This document describes…".
- Plain words, short sentences (under 25 words), paragraphs of 3 sentences max.
- Specifics over adjectives: numbers with units, names, dates.
- No intro section, no "key takeaways", no recap at the end, no emoji.
- Title in sentence case; `<title>` tag in lower case.
- `.meta` line under the lede: the date and the scope or audience. Nothing else.
- Cite looked-up facts with a link next to the claim.

## Design rules (don't fight the template)

- One accent colour, used for the one thing that matters. Never more than one
  `.note`/`.warn` per section, never more than two accent boxes per diagram.
- No new fonts, gradients, shadows, rounded cards, icons or emoji: the calm,
  flat, hairline look is the style.
- No colours outside the CSS variables, so the light theme keeps working.
- No external CSS, JS, fonts or images. The file must work offline.
- No native-looking controls; if interaction is needed, `<details>` is enough.

## Files

- `assets/template.html` — the page skeleton and every style. Components are in
  a comment block in the body: copy what you need.
- `references/diagrams.md` — how to draw the SVGs: frame, grid, box sizes,
  characters per width, connectors, loops, bar charts.
- `scripts/shot.sh` — headless Chrome screenshot for the look step.
