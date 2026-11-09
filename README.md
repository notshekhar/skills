# skills

Agent skills I use with Claude Code, Codex and [loop](https://github.com/notshekhar/loop).
Each folder is one skill in the standard `SKILL.md` format, so any agent that
reads skills can use it.

| skill | what it does |
| --- | --- |
| [html-reports](html-reports/) | Design docs, reports and explainers as one self-contained HTML file: calm dark/light style, tables, stat rows, callouts and hand-drawn SVG diagrams, checked with a headless Chrome screenshot. |

## Install

Clone once, then link the skills you want into each agent's skills folder:

```bash
git clone https://github.com/notshekhar/skills ~/skills

# Claude Code
ln -s ~/skills/html-reports ~/.claude/skills/html-reports
# Codex
ln -s ~/skills/html-reports ~/.codex/skills/html-reports
# loop
ln -s ~/skills/html-reports ~/.loop/agent/skills/html-reports
```

`git pull` updates every agent at once.

## License

MIT
