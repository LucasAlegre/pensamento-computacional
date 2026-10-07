# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Course website for INF05008 – Pensamento Computacional (INF/UFRGS), taught in **Pyret**. It is a React 19 + Vite SPA deployed to GitHub Pages at `https://lucasalegre.github.io/pensamento-computacional/`. Nearly all content (labs, exercises, topic pages) lives in Markdown and `.arr` files under `src/data/` and is rendered with live, runnable Pyret editors. All user-facing text is in Brazilian Portuguese; keep new content and UI strings in Portuguese.

## Commands

```bash
npm install --legacy-peer-deps   # CI installs this way; plain install may fail on peer deps
npm run dev                      # Vite dev server at http://localhost:5173/pensamento-computacional/
npm run build                    # production build to dist/
npm run lint                     # ESLint (flat config in eslint.config.js)
npm run preview                  # serve dist/
```

There is no test suite. Pushing to `main` deploys automatically (`.github/workflows/deploy.yml` runs `npm run deploy`: build, copy `index.html` to `404.html` for SPA deep links, then push `dist/` to the `gh-pages` branch).

## Architecture

### Routing and base path
`src/App.jsx` defines all routes under `BrowserRouter basename="/pensamento-computacional"`, matching `base` in `vite.config.js`. Both must change together. Public asset URLs in components are built from `import.meta.env.BASE_URL`.

### Content is bundled at build time
Pages load content with `import.meta.glob(..., { query: '?raw', eager: true })` or `?raw` imports, so Markdown and `.arr` files become strings in the JS bundle. Adding or editing a content file needs no code change as long as it matches an existing glob.

### Pyret rendering
`src/components/PyretEmbed.jsx` wraps `@ironm00n/pyret-embed` (an iframe of code.pyret.org). Every Markdown renderer (`LabPage`, `ExerciseItem`, `Learning`, `DataTypes`, `PyretStyleGuide`) overrides ReactMarkdown's `code` component so that a fenced block tagged `pyret` becomes a live editor. Fence metadata `height=N` sets the editor height in pixels; without it, the height is computed from the line count. Markdown is rendered with `remark-math`/`rehype-katex` (LaTeX via `$...$`) and `remark-gfm`. The lab and topic pages also use `rehype-raw`, so raw HTML (`<img>`, `<br>`) works there.

### Labs (`/labs/:semesterId/:labId`)
- `src/data/labsConfig.js` lists the semesters (newest first) and their labs. It drives `/labs`.
- `LabPage.jsx` renders `src/data/labs/<semesterId>/lab<labId>.md`.
- Inside a `pyret` fence, a single line `file: src/data/labs/2026-2/lab3-template.arr` embeds that file's contents. Lookup is a suffix match over `src/codigos_pyret/*.arr` and `src/data/labs/**/*.arr`.
- Relative image paths in lab Markdown (`images/lab3/foo.png`) resolve against `src/data/labs/<semesterId>/`.
- Per-semester files follow the pattern `labN.md`, `labN-template.arr` and `labN-solucao.arr`. Unreleased labs are stub `.md` files (for example `# Laboratório 4`).

### Pyret support libraries are served from three places
Student templates load helper libraries over the network, not from the bundle:
- `include url("https://lucasalegre.github.io/pensamento-computacional/src/data/labs/<lib>.arr")` is served from the **copy in `public/src/data/labs/`**, which Vite copies to `dist/` verbatim.
- CSV data used by the libraries (`chat-lib3.arr`, `herois-lib2.arr`) is fetched through jsDelivr from GitHub `main` (`cdn.jsdelivr.net/gh/lucasalegre/pensamento-computacional@main/src/data/labs/2026-2/*.csv`). Images are fetched from `raw.githubusercontent.com/.../main/...`.
- The originals in `src/data/labs/` (and `src/data/labs/2026-1/pokemon-lib*.arr`) are only what the lab page displays through `file:` blocks.

These copies are maintained by hand and have drifted apart before. When you change a library or CSV, update both the `public/src/data/labs/` copy and the `src/` copy, and check them with `cmp`. Moving or renaming files referenced by these URLs breaks student code that is already distributed.

### Exercises (`/exercises`, `/exercises/:id`)
All exercises live in a single file, `src/data/exercises.md`. `src/utils/loadExercises.js` parses it line by line, so the format is strict:

````
# Tópico: <topic name>

## Exercício: <title>
**ID:** <unique id, used in the URL>
**Dificuldade:** Fácil | Médio | Difícil | Resolvido

<statement in Markdown; may contain ```pyret blocks and images>

### Testes
```pyret height=500
<initial editor contents / check: block>
```
````

`### Testes` switches the parser from the statement to the test code, so don't use that heading inside a statement. Difficulty colors come from `src/utils/difficultyStyles.js`. Exercise images resolve against `src/data/` (for example `images/x.png` maps to `src/data/images/x.png`). `scripts/convert_exercises.js` is a one-off legacy converter from a JSON file that no longer exists.

### Topic pages
Each topic is a hand-wired page. `Learning.jsx`, `DataTypes.jsx` and `PyretStyleGuide.jsx` each render one file from `src/data/topics/*.md`, with a duplicated ReactMarkdown setup and a `TableOfContents` sidebar (which scrapes `h2`/`h3` from the DOM). `Functions.jsx` is inline JSX. To add a topic, you need a page component, a route in `App.jsx`, a dropdown link in `components/Layout.jsx` and a card in `pages/Topics.jsx`.

### Not part of the site
- `src/data/codigos-aulas/`: lecture code archive. It is not imported anywhere.
- `pages/Examples.jsx` and `components/CodeViewer.jsx`: unrouted; they read `src/codigos_pyret/`.
- `provas-pensamento-computacional/`: a separate, nested git repo of LaTeX exams. It is untracked here, so don't add it to this repo.
- `README.md`: the stock Vite template.
