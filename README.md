# everett.sty

A personal LaTeX setup for mathematical notes, books, and handouts, with complete example templates.

The supplied book has a **Panbook-inspired design** with Catppuccin Frappé
accents on white in light mode and Macchiato in dark mode: a narrow text column and
wide right margin, Palatino-style text, colored section headings, theorem
boxes, learning objectives, and numbered exercises. It keeps KOMA-Script and
the existing mathematical commands; it does not require the Tufte document
class or Panbook's Markdown toolchain. The design is inspired by
[Boaz Barak's Panbook](https://github.com/boazbk/panbook/tree/master/latex-book).

- **`everett.sty`** supplies the document style: Catppuccin colors by default, an optional `panbook` theorem style, chapter and page headings, diagrams, tables, algorithms, cross-references, and bibliography configuration.
- **`macro.sty`** supplies mathematical notation: number sets, operators, delimiters, arrows, and shortcuts for algebra, geometry, analysis, and related subjects.

Load the packages separately, with `everett` first when using both. The book template uses the KOMA-Script `scrbook` class. The handout template uses `scrartcl` with `\usepackage[handout]{everett}`; this option disables chapter-specific formatting and part mini-contents. The package is not a drop-in style for standard `article`, `amsart`, Beamer, or `tufte-handout`. `macro.sty` can also be used on its own.

The **handout template** takes its layout cues from the
[Tufte-LaTeX sample handout](https://github.com/Tufte-LaTeX/tufte-latex/blob/master/sample-handout.tex):
a narrow text column, a wide right margin, Palatino-style text, unnumbered
italic headings, sidenotes, and margin and full-width graphics. It uses
KOMA-Script with `everett.sty`, so no Tufte class or external image assets
are required. Both Catppuccin light and dark modes are included.

## Quick start

1. Install a LaTeX distribution with **pdfLaTeX, Biber, and latexmk**. See [requirements](#requirements).
2. Download or clone this repository.
3. Open a terminal in the repository and build the supplied book:

   ```sh
   cd book-template
   latexmk -pdf -outdir=build main.tex
   ```

4. Open `book-template/build/main.pdf`.
5. Edit the title and author in `book-template/main.tex`, then replace or extend the chapters under `book-template/sections/`.

Run the same build command after editing. `latexmk` runs LaTeX and Biber as needed to resolve citations and references. Part contents may require additional LaTeX passes after changing the book structure; see [building manually](#building-manually).

Alternatively, run `make book` from the repository root. This refreshes the template's package copies and builds the book. The `book-template` folder includes both packages and can be copied into another directory as a starting project.

### Light and dark modes

Light mode uses the [official Frappé accent colors](https://catppuccin.com/palette/#frapp%C3%A9)
on a pure white (`#FFFFFF`) page, with dark Frappé neutrals for body text
and pale neutral tints for secondary surfaces. This is the default. Dark
mode uses Macchiato with a dark blue-gray background and light text.

From the repository root:

```sh
make book-light   # Frappé on white: book-template/build/light/main-light.pdf
make book-dark    # Macchiato: book-template/build/dark/main-dark.pdf
make book-modes   # Build both, with separate auxiliary files.
```

Without Make, run these commands from `book-template`:

```sh
latexmk -pdf -outdir=build/light main-light.tex
latexmk -pdf -outdir=build/dark main-dark.tex
```

The two entry files load the same `main.tex`, so edits to chapters or metadata
apply to both. For the ordinary `main.tex` build or a standalone chapter,
set the default in `preamble.tex` to `\providecommand{\booktheme}{light}` or
`\providecommand{\booktheme}{dark}`. The explicit entry files override that
default. Use one mode per PDF.

## Requirements

Use a complete [TeX Live installation](https://www.tug.org/texlive/acquire-netinstall.html), [MacTeX on macOS](https://www.tug.org/mactex/mactex-download.html), or [MiKTeX](https://miktex.org/howto/install-miktex). A full installation is convenient because `everett.sty` loads a broad set of packages. MiKTeX can install missing packages through its package manager.

The main dependencies include:

| Purpose | Packages or tools |
| --- | --- |
| Document class and headers | KOMA-Script (`scrbook`, `scrlayer-scrpage`) |
| Mathematics and fonts | AMS packages, `mathtools`, `lmodern`, `mathrsfs`, `stmaryrd`, `wasysym`, `derivative`, `bm`, `systeme` |
| Book typography | `mathpazo`, `tgpagella`, `tgheros`, `inconsolata` |
| Book margins and wide content | `sidenotes`, `marginfix`, `changepage`, `ragged2e` |
| Theorem styling | `amsthm`, `thmtools`, `mdframed`, `tcolorbox` |
| Drawings and plots | `tikz`, `tikz-cd`, `pgfplots`, `prerex` |
| References and contents | `hyperref`, `cleveref`, `minitoc`, `biblatex`, **Biber** |
| Code, algorithms, and tables | `listings`, `algorithm`, `algpseudocode`, `booktabs`, `multirow` |
| Macro helpers | `enumitem`, `yhmath` |
| Template structure | `subfiles`, `babel`, `csquotes` |
| Build automation | **latexmk**; optionally **Make** |

The package files list all dependencies. If LaTeX reports `File 'something.sty' not found`, install the package providing that file using your distribution's package manager. Copying the two local `.sty` files into your project installs `everett` and `macro` for that project.

Check that your terminal can find the build tools:

```sh
pdflatex --version
biber --version
latexmk -v
```

The examples use pdfLaTeX. No shell escape, Python, external figure downloads, or external code highlighter is required.

### Overleaf

Zip the **contents** of `book-template` and [upload the ZIP as a project](https://docs.overleaf.com/managing-projects-and-files/uploading-a-project). Keep `main.tex`, `main-light.tex`, `main-dark.tex`, both `.sty` files, both `.bib` files, `preamble.tex`, `book-design.tex`, `macros/`, and `sections/` together. Exclude generated `build/` and `out/` directories. Select `main-light.tex` for Frappé on white or `main-dark.tex` for Macchiato as the [main document](https://docs.overleaf.com/getting-started/recompiling-your-project/the-main-document), choose pdfLaTeX, and recompile. Select `main.tex` to use the default set in the preamble. The bibliography configuration requests Biber automatically.

### Optional installation for multiple local projects

With TeX Live or MacTeX, find your personal TEXMF directory:

```sh
kpsewhich -var-value=TEXMFHOME
```

Place `everett.sty` and `macro.sty` inside its `tex/latex/everett/` subdirectory. Verify discovery with `kpsewhich everett.sty` and `kpsewhich macro.sty` from outside this repository. A project-local copy takes precedence, so update old local copies when upgrading your shared installation. For MiKTeX, use its user TEXMF-root settings and refresh its filename database as needed.

## Start a document from scratch

The minimal example below uses the base package's Frappé on white appearance. Copy the
complete `book-template` folder for the Panbook-inspired layout and its
additional teaching environments.

Create a folder containing `main.tex`, `everett.sty`, `macro.sty`, `references.bib`, and `images.bib`. Copy the two packages from the repository. Create both bibliography files; they can be empty until you add sources. Save this as `main.tex`:

```latex
\documentclass[12pt,a4paper,oneside]{scrbook}
\usepackage[english]{babel}
\usepackage{csquotes}
\usepackage{everett}
\usepackage{macro}

\title{My mathematical notes}
\author{Your name}
\date{\today}

\begin{document}
\frontmatter
\maketitle
\tableofcontents

\mainmatter
\chapter{Integers}
\begin{definition}[Even integer]\label{def:even}
An integer $n\in\ZZ$ is even if $n=2k$ for some $k\in\ZZ$.
\end{definition}

\begin{theorem}\label{thm:even-sum}
The sum of two even integers is even.
\end{theorem}
\begin{proof}
Write $a=2r$ and $b=2s$, where $r,s\in\ZZ$.
Then $a+b=2(r+s)$, which is even by \cref{def:even}.
\end{proof}

\begin{eg}
The integers $4$ and $6$ are even, and so is their sum $10$.
\end{eg}

\backmatter
\printbibliography[heading=bibintoc,title={References}]
\end{document}
```

Build from that folder with `latexmk -pdf -outdir=build main.tex`. The bibliography remains empty until a source is cited or included with `\nocite`.

## Using everett.sty

### Theorems, examples, and proofs

Use these environment names exactly: the example environment is `eg`, and the proposition environment is `prop`.

| Environment | Displayed heading | Numbering |
| --- | --- | --- |
| `definition` | definition | Numbered |
| `theorem` | theorem | Numbered |
| `lemma` | lemma | Numbered |
| `prop` | proposition | Numbered |
| `eg` | example | Unnumbered |
| `corollary` | corollary | Unnumbered |
| `proof` | Proof, or your optional title | Unnumbered; ends with a QED symbol |
| `explanation` | Explanation, with an optional subtitle | Unnumbered |
| `remark`, `note` | Remark, Note | Unnumbered |
| `notation`, `problem`, `observe`, `property`, `intuition` | Corresponding descriptive heading | Unnumbered |
| `previouslyseen`, `uovt` | As previously seen, UOVT | Unnumbered |

Without the `panbook` option, definitions and results use purple styling;
examples and explanations use teal; remarks and notes have yellow side
rules. With `\usepackage[panbook]{everett}`, the environments use the book's
warm definition accents, blue result boxes, green examples, and gold
remarks. Box fills follow the selected light or dark background. The package
gives each numbered environment its own counter,
running through the document. The book template resets these counters within
chapters, producing labels such as theorem 2.1 and definition 2.1.

```latex
\begin{lemma}[A useful observation]\label{lem:observation}
For every $x\in\RR$, $x^2\geq 0$.
\end{lemma}
\begin{proof}[Direct proof]
A square of a real number is nonnegative.
\end{proof}
\begin{explanation}[Geometric interpretation]
The graph of $y=x^2$ lies on or above the horizontal axis.
\end{explanation}
\begin{remark}
Equality occurs precisely when $x=0$.
\end{remark}
```

Put `\label` immediately after the beginning of a numbered environment. Use `\cref{lem:observation}` for a reference including the type, `\Cref` at the start of a sentence, and `\eqref{eq:energy}` for a parenthesized equation number. Unnumbered environments do not provide a theorem number to reference.

### Equations and diagrams

AMS mathematics, TikZ, PGFPlots, and `tikz-cd` are already loaded:

```latex
\begin{equation}\label{eq:energy}
  \norm{v}^2 = \sum_{i=1}^{n} v_i^2.
\end{equation}

\[
\begin{tikzcd}
  \ZZ \arrow[r, "\pi"] \arrow[d, "\id"']
    & \Zc{n} \arrow[d, "\id"] \\
  \ZZ \arrow[r, "\pi"'] & \Zc{n}
\end{tikzcd}
\]
```

The rings chapter demonstrates a commutative diagram and a `booktabs` table; the calculus chapter demonstrates a plot; the computation chapter demonstrates an algorithm and a code listing. `listings` typesets code; it does not execute it. `algorithm` and `algpseudocode` typeset pseudocode.

### Colors, layout, and numbering

The default mode uses Catppuccin Frappé accents on pure white. Use `\usepackage[light]{everett}` to
select Frappé on white explicitly, or `\usepackage[dark]{everett}` for Macchiato.
Both options set the page background, body text, and accent colors. They can
be combined with `panbook`, for example `\usepackage[panbook,dark]{everett}`.
If both `light` and `dark` are supplied, the last one wins. The supplied book
passes its `\booktheme` setting to the package and adds its layout in
`book-design.tex`; see [light and dark modes](#light-and-dark-modes).

Put project-specific changes after loading the packages, usually in `preamble.tex`:

```latex
\geometry{margin=28mm,headheight=16pt}
\setcounter{tocdepth}{2} % Include subsections in the main contents.
\hypersetup{urlcolor=ctpTeal,linkcolor=ctpBlue}
\colorlet{ctpChapter}{ctpBlue}

% Optional: restart each result type within a chapter.
\counterwithin{theorem}{chapter}
\counterwithin{lemma}{chapter}
\counterwithin{prop}{chapter}
\counterwithin{definition}{chapter}
% Keep PDF link targets distinct when these counters restart.
\renewcommand{\theHtheorem}{\theHchapter.\arabic{theorem}}
\renewcommand{\theHlemma}{\theHchapter.\arabic{lemma}}
\renewcommand{\theHprop}{\theHchapter.\arabic{prop}}
\renewcommand{\theHdefinition}{\theHchapter.\arabic{definition}}
```

The template already applies its own margins, chapter-based result numbering,
and code-listing style. Edit those settings rather than adding conflicting
duplicates: page geometry and typography live in `book-design.tex`; numbering
and listings live in `preamble.tex`. The root package's theorem-style
declarations control frame and fill choices. The example above applies to the
base package; the book design maps its heading and callout colors to the
selected Catppuccin palette.

## Using macro.sty

When using both packages, load `\usepackage{everett}` followed by `\usepackage{macro}`. For notation without the book styling:

```latex
\documentclass{article}
\usepackage{macro}
\begin{document}
For $x\in\RR$, write $\abs{x}$ for its absolute value.
\end{document}
```

`macro.sty` loads the dependencies needed by its commands. Mathematical shortcuts belong inside `$...$`, `\(...\)`, or a displayed math environment unless otherwise noted.

| Category | Examples | Meaning |
| --- | --- | --- |
| Number sets | `\NN`, `\ZZ`, `\QQ`, `\RR`, `\CC`, `\FF` | Blackboard-bold N, Z, Q, R, C, F |
| Delimiters | `\abs{x}`, `\norm{v}`, `\floor{x}`, `\ceiling{x}` | Sized absolute value, norm, floor, ceiling |
| Basic notation | `\cbrt{x}`, `\half`, `\eps`, `\defeq` | Cube root, one-half, variant epsilon, definition equality |
| Accents | `\ol{x}`, `\ul{x}`, `\wt{x}`, `\wh{x}` | Overline, underline, wide tilde, wide hat |
| Maps and arrows | `\id`, `\taking{f}`, `\injto`, `\surjto`, `f\inv` | Identity, labeled arrow, injection, surjection, inverse |
| Operators | `\argmin`, `\argmax`, `\lcm`, `\rank`, `\Tr` | Properly spaced mathematical operators |
| Algebra | `\Hom`, `\End`, `\Aut`, `\Gal`, `\GL`, `\SL`, `\Ker`, `\coker` | Algebraic operators |
| Quotients | `\Zc{n}`, `\Zcc{n}`, `\Zm{n}` | Integers modulo n, parenthesized denominator, unit group |
| Geometry | `\dang`, `\ray{AB}`, `\seg{AB}`, `\arc{AB}` | Measured angle, ray, segment, arc |
| Calculus | `\fpartial{f}{x}` | Partial derivative as a fraction |
| Cyclic expressions | `\cycsum`, `\symsum`, `\cycprod`, `\symprod` | Sum/product with cyclic or symmetric subscript |
| Script and category notation | `\SA`, `\SB`, `\OO`, `\catname{Set}`, `\obj`, `\op` | Selected script letters, category names, objects, opposite category |
| Further subjects | `\Spec`, `\Proj`, `\Ext`, `\Tor`, `\HdR`, `\Frob`, `\ZFC` | Geometry, homological algebra, topology, number theory, set theory |

Some commands are suffixes: write `f\inv`, `G\ab`, and `\catname{C}\op`. `\im` is an image superscript; use `\img` or `\Img` for an image operator. `\EE` gives the expectation symbol but does not add brackets automatically.

```latex
\[
  f\colon \RR \taking{f} \RR,
  \qquad f(x) \defeq \abs{x},
  \qquad \Hom(\Zc{n},G).
\]
```

Text helpers include `\vocab{important term}`, `\mailto{name@example.com}`, and `\hrulebar`. `\ii` is equivalent to `\item`.

Additional environments, shown with both packages loaded:

```latex
\begin{problem}
Find the inverse of $3$ modulo $5$.
\end{problem}
\begin{soln}
Since $3\cdot2\equiv1\pmod5$, the inverse is $2$.
\end{soln}

The assumptions are
\begin{parlist}
  \item $G$ is finite;
  \item $H\normalin G$.
\end{parlist}
```

`soln` produces a proof titled “Solution”; `subproof` uses a black square at the end and accepts an optional title. `parlist` produces an inline numbered list. `gobble` hides typeset material but still processes its LaTeX; it is not a general comment or verbatim environment. `problem` comes from `everett.sty`.

**Command compatibility:** `macro.sty` deliberately redefines `\AA`, `\th`, `\Re`, and `\Im`. The first two no longer produce the original text letters. Many short names use `\newcommand`, so another package or your preamble defining the same name can cause an “already defined” error. Check these aliases when adding the package to an existing project.

Put your own notation in `book-template/macros/macros.tex`, which loads after the packages. The template includes `\angles{v,w}` for angle brackets and `\dd` for an upright differential. These are template additions, not commands supplied by `macro.sty`.

## Complete bibliography setup

`everett.sty` already loads `biblatex` with `backend=biber`, `style=alphabetic`, and `backref=true`. Citation labels use author/year information with custom formatting, and bibliography entries list the pages where they were cited.

It also registers **`references.bib` and `images.bib`**. Keep both in the document's working directory, even if one is empty. Do not reload `biblatex`, repeat those `\addbibresource` calls, or mix in `\bibliographystyle` and `\bibliography`.

### 1. Add bibliographic records

For example, place this record in `references.bib`:

```bibtex
@book{concrete1994,
  author    = {Graham, Ronald L. and Knuth, Donald E. and Patashnik, Oren},
  title     = {Concrete Mathematics},
  subtitle  = {A Foundation for Computer Science},
  edition   = {2},
  date      = {1994},
  publisher = {Addison-Wesley}
}
```

The citation key `concrete1994` is your identifier, not the printed citation label. Use unique keys. Separate authors with `and`, protect proper-name capitalization with braces where necessary, and use `doi` or `url` fields for source links.

For a figure credit in `images.bib`, include `keywords = {image}`. For example, this records an original figure in the supplied template:

```bibtex
@misc{template-parabola,
  author       = {{everett.sty template}},
  title        = {The parabola f(x) = x squared},
  date         = {2026},
  howpublished = {Original {PGFPlots} illustration in the calculus chapter},
  note         = {Generated from the function x squared; no external image asset},
  keywords     = {image}
}
```

Replace this record with the actual author, title, date, URL, and any required attribution when using someone else's figure. Storing an entry in `images.bib` does not classify it as an image; the `image` keyword does.

### 2. Cite sources

```latex
See \cite{concrete1994} for further examples.
Compare \parencite[Section 1.1]{concrete1994}.
\textcite{concrete1994} develops these methods systematically.

% In a figure environment:
\caption{A parabola. Figure credit: \protect\cite{template-parabola}.}
```

Only cited entries are printed by default. Add `\nocite{concrete1994}` to include a particular uncited source, or `\nocite{*}` to include every entry from every registered database.

### 3. Print the bibliography

For one combined bibliography, put this near the end of the document:

```latex
\printbibliography[heading=bibintoc,title={References}]
```

The template instead prints separate references and figure credits:

```latex
\printbibliography[
  heading=bibintoc,
  title={References},
  notkeyword=image
]
\printbibliography[
  heading=bibintoc,
  title={Figure credits},
  keyword=image
]
```

Use either the combined form or the split form to avoid printing entries twice. `heading=bibintoc` adds the heading to the main table of contents.

### 4. Build with Biber

From the directory containing `main.tex`, `references.bib`, and `images.bib`:

```sh
latexmk -pdf -outdir=build main.tex
```

To add another database, register it in your preamble with `\addbibresource{additional-sources.bib}`.

To choose another citation style or backend, change the existing `biblatex` loading line in `everett.sty` and keep the template copy synchronized. Loading `biblatex` again with different options causes an option clash. Changing styles may also require revisiting the package's custom bibliography formatting.

## Working with the handout template

Build from the repository root:

```sh
make handout        # handout-template/build/main.pdf (light by default)
make handout-light  # handout-template/build/light/main-light.pdf
make handout-dark   # handout-template/build/dark/main-dark.pdf
make handout-modes  # Both explicit modes
```

These targets refresh the local package copies before compiling. The
`handout-template/` folder is portable: copy the whole folder to start a
new project. From inside that folder, build with
`latexmk -pdf -outdir=build main.tex`. For Overleaf, upload the folder's
contents, choose pdfLaTeX, and select `main.tex`, `main-light.tex`, or
`main-dark.tex` as the main document. The requirements are the same as the
book template, including Biber.

```text
handout-template/
  main.tex              # Metadata and a two-page mathematical sample
  main-light.tex        # Explicit Frappé on white entry point
  main-dark.tex         # Explicit Macchiato entry point
  preamble.tex          # Theme, package loading, and your notation/settings
  handout-design.tex    # Tufte-inspired typography and margin layout
  everett.sty           # Portable copy of the root package
  macro.sty             # Portable copy of the root package
  references.bib        # Bibliography sources
  images.bib            # External figure credits; empty in this sample
```

Edit the title, subtitle, author, course label, running title, and content
in `main.tex`. Change the default theme in `preamble.tex` and the layout
in `handout-design.tex`. The explicit entry points override the default
theme. Numbered theorem environments retain their independent,
document-wide counters. Sections are unnumbered by default; put
`\setcounter{secnumdepth}{2}` after the design is loaded to number them.

The template supplies these layout helpers:

| Command or environment | Use |
| --- | --- |
| `\sidenote{...}` or `\footnote{...}` | A numbered note in the right margin |
| `\marginnote{...}` | An unnumbered margin note |
| `\sidecite{key}` | A full BibLaTeX reference in a numbered sidenote |
| `\cite{key}` | An ordinary inline citation |
| `marginfigure`, `margintable` | A small figure or table in the margin |
| `figure*`, `table*` | A float spanning the text and margin columns |
| `fullwidth` | Text spanning both columns |
| `\newthought{Opening words}` | A paragraph opening in small caps |
| `exercise` | A numbered exercise |

For instance:

```latex
\newthought{Begin with an example.} Explain the main idea here.
\sidenote{A short supporting observation.}

\begin{theorem}\label{thm:sample}
For every $x\in\RR$, $x^2\geq 0$.
\end{theorem}
\begin{proof}
A square of a real number is nonnegative.
\end{proof}
```

The handout adapts the sample's visual approach rather than its entire
class interface. Use BibLaTeX/Biber and `\printbibliography`, as in the
rest of this repository. Margin captions and notes use the current
Catppuccin palette. Ordinary `figure` and `table` floats keep the main
column width, with captions below; use `\sidecaption{...}` inside such a
float to place its caption in the margin. Keep notes out of the vertical
space occupied by full-width material, and check dense margins after
editing. Notes placed with explicit offsets use fixed positioning and
may need manual adjustment.

## Working with the book template

```text
book-template/
  main.tex                         # Metadata, chapter order, bibliographies
  main-light.tex                   # Explicit Frappé on white entry point
  main-dark.tex                    # Explicit Macchiato entry point
  preamble.tex                     # Packages and document-level formatting
  book-design.tex                  # Panbook-inspired layout, fonts, callouts
  everett.sty                      # Portable copy of the root package
  macro.sty                        # Portable copy of the root package
  references.bib                   # Mathematical and technical sources
  images.bib                       # Figure credits with keyword=image
  macros/
    macros.tex                     # Your additional notation
  sections/
    guide/getting-started.tex       # Writing and navigation examples
    abstract/group.tex             # Definitions, results, proofs, exercises
    abstract/ring.tex               # Rings, quotient diagram, multiplication table
    analysis/calculus.tex           # Equations, calculus notation, function plot
    technical/examples.tex         # Algorithms, code, inline lists, solutions
    appendix/notation.tex           # Notation reference
  build/                           # Generated by the build command
```

There are three populated parts: **Writing mathematical notes**, **Algebra**, and **Analysis and computation**, followed by a notation appendix and bibliographies. The main file uses `\frontmatter` for preliminary pages, `\mainmatter` for numbered chapters, `\appendix` for appendices, and `\backmatter` for references. `\parttoc` adds a contents list for each part.

### Book layout and teaching environments

The book uses 10-point text on A4 paper, with a 112 mm main column, a 9 mm
gap, and a 53 mm right margin. Palatino-style text and mathematics are paired
with a sans-serif heading font and Inconsolata code. The PDF is built with
the same pdfLaTeX and Biber commands as before.

These additions are defined or loaded by `book-design.tex`:

| Command or environment | Purpose |
| --- | --- |
| `\sidenote{...}` | A numbered note beside the text |
| `\marginnote{...}` | An unnumbered margin note |
| `marginfigure`, `margintable` | A small figure or table in the margin, with normal captions and labels |
| `\sidecaption{...}` | A margin caption inside an ordinary figure or table |
| `fullwidth` | Text or a display spanning the main column and margin |
| `figure*`, `table*` | A full-width figure or table |
| `objectives` | A short learning-objectives card in the margin |
| `bigidea` | A numbered box for a central principle; optional title |
| `exercise` | A numbered exercise; optional title |
| `recap` | A summary box at the end of a section or chapter |

`bigidea` and `exercise` restart their numbering in each chapter and support
`\label` and `\cref`. Existing environments such as `definition`, `theorem`,
`eg`, `problem`, and `soln` keep working. A typical chapter opening is:

```latex
\chapter{Groups}
\begin{objectives}
\begin{itemize}
  \item Recognize the group axioms.
  \item Prove cancellation.
\end{itemize}
\end{objectives}

\section{The group axioms}
An inverse undoes multiplication.\sidenote{The side matters in a
noncommutative group.}

\begin{bigidea}[Cancellation]\label{idea:cancel}
Multiply by an inverse on the same side of both expressions.
\end{bigidea}
```

Use short notes and objectives; keep substantial explanations in the main
column. Put margin commands in ordinary text rather than inside theorem
boxes. Ordinary sidenotes and margin floats can move to avoid collisions;
unnumbered `\marginnote` and `\sidecaption` content needs visual checking.
Reserve a clear margin alongside `fullwidth`, `figure*`, and `table*`
material. The sample chapters demonstrate margin objectives, a quotient-map
figure, a plot with a side caption, and a full-width notation table.

Adjust the geometry, fonts, headings, and callouts in `book-design.tex`.
The `panbook` package option controls the existing theorem styles; it is
opt-in so other documents can keep the base styling. Both styles support
Frappé accents on white in light mode and Macchiato in dark mode. Select the book's mode through
`\booktheme` or the explicit entry files described above.

### Add a chapter

Create `sections/abstract/fields.tex`:

```latex
\documentclass[../../main.tex]{subfiles}
\begin{document}
\chapter{Fields}\label{chap:fields}
\section{Definitions}
\begin{definition}
A field is a commutative ring with $1\ne0$ in which
every nonzero element has a multiplicative inverse.
\end{definition}
\end{document}
```

Add it at the appropriate position in `main.tex` with `\subfile{sections/abstract/fields.tex}`. The path in `\documentclass[../../main.tex]{subfiles}` is relative to the chapter file; adjust it for a different folder depth. The path in `\subfile` is relative to the book root.

Compile a chapter independently **from the `book-template` directory**:

```sh
latexmk -pdf -outdir=build/group sections/abstract/group.tex
```

The result is `build/group/group.pdf`. Keep the working directory at the book root so bibliography and project paths resolve. A standalone chapter inherits the preamble but does not include the rest of `main.tex` or its bibliography-printing commands. References to other chapters cannot resolve in an isolated chapter; use the full book build to check them. The full build is also the authoritative check for numbering and part contents.

### Building manually

Without `latexmk`, run these commands from `book-template`:

```sh
mkdir -p build
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
biber --input-directory=build --output-directory=build main
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=build main.tex
```

The first LaTeX pass writes `main.bcf`; Biber reads the databases and writes `main.bbl`; later passes resolve citations, references, and contents. The extra pass gives part contents time to settle. Run another LaTeX pass if the log requests one. Without a build directory, use `pdflatex main`, `biber main`, then repeated `pdflatex main`.

### Package copies and generated files

The root-level `.sty` files are the canonical sources. From the repository root:

```sh
make sync-template   # Copy both root packages into book-template.
make check-template  # Check that both copies match.
make book            # Sync the copies and build the book.
make book-modes      # Sync the copies and build both light and dark PDFs.
make clean           # Clean all three book builds' auxiliaries; keep PDFs.
```

Without Make, synchronize with `cp everett.sty macro.sty book-template/`. Always refresh these copies after editing a root package. Project-local copies take precedence over an installed version.

Generated `build/` and older `out/` files are compiler output. Keep source `.tex`, `.sty`, and `.bib` files when cleaning a project.

### Other templates

`latex-templates/homework/homework.tex` and `latex-templates/paper/template.tex` are independent legacy templates. They do not load `everett.sty` or `macro.sty`. The homework template supplies its own problem numbering and headers; the paper template uses `amsart` and `amsrefs`. Use the book template for the integrated setup described here.

## Troubleshooting

| Symptom | What to check |
| --- | --- |
| `everett.sty` or `macro.sty` cannot be found | Keep the files beside the main document or install them in your personal TEXMF tree. Check the working directory and `kpsewhich`. |
| Another `.sty` file is missing | Install that dependency through your TeX distribution's package manager. |
| Undefined `\chapterformat`, `\RedeclareSectionCommand`, or chapter commands | Use the supplied `scrbook` class with `everett.sty`. |
| Undefined `\RR`, `\abs`, or another notation shortcut | Load `macro.sty`; loading `everett.sty` alone does not load it. |
| A command is “already defined” | Check your preamble and other packages for a conflicting short macro name. |
| Missing `references.bib` or `images.bib` | Create both in the working directory, even if one is empty. Run chapter builds from the book root. |
| Citation keys appear instead of labels, or citations show `?` | Check the key, run Biber on the correct job name, then rerun LaTeX. Check `build/main.blg` for bibliography errors. |
| Biber cannot find `main.bcf` | Run LaTeX successfully first; use the same build-directory options. Pass `main`, not `main.tex`, to Biber. |
| Bibliography is empty | Cite a source or use `\nocite`; include `\printbibliography` inside the document. Check keyword filters. |
| Biber reports an incompatible control-file version | Update Biber and `biblatex` together using the same TeX distribution. |
| Main or part contents are empty or out of date | Finish the LaTeX reruns after changing parts or chapters. Check that `\tableofcontents` and the relevant `\parttoc` are present. |
| References show `??` in a standalone chapter | Build the whole book; isolated chapters do not import labels from other chapters. |
| `biblatex` option clash | Remove the second `\usepackage{biblatex}`; configure the existing load in `everett.sty` instead. |
| Changing the root style has no effect on the book | Refresh the copies inside `book-template`. |
| Dark mode still looks light | Refresh the template package copies and build `main-dark.tex`; open `build/dark/main-dark.pdf`. Check for later `\pagecolor` or `\color` overrides. |

The tested TeX Live build still reports KOMA-Script advisories about `minitoc`
and `emptypage`, a `stmaryrd` bold-font substitution, and a `microtype` footnote
patch warning. These do not stop the supplied example from compiling. Check
separately for missing citations, undefined references, and text overflowing
the page, and inspect the PDF after changing the layout.
