# artiombn's Blog — Zola

This is a [Zola](https://www.getzola.org/) port of the original Emacs
`org-publish` site. The repository root now contains the converted Markdown
site.

## Structure

```
.
├── config.toml
├── content/
│   ├── _index.md            # home page (shows recent posts)
│   ├── apps.md              # /apps/
│   ├── sitemap.md           # /sitemap/ (human-readable)
│   └── posts/
│       ├── _index.md        # /posts/ listing (replaces the org sitemap)
│       ├── dsl.md
│       └── concurrency.md
├── static/
│   └── static/              # keeps the original /static/*.png URLs
├── templates/
│   ├── base.html            # nav bar + simple.css
│   ├── index.html           # home + recent posts
│   ├── section.html         # posts listing
│   ├── sitemap.html         # human-readable sitemap
│   └── page.html            # regular pages / posts
└── README.md
```

## Usage

```sh
# Build into ./public
zola build

# Preview at http://127.0.0.1:1111
zola serve

# Check internal links (external 403s from StackOverflow/ResearchGate are expected)
zola check
```

Set `base_url` in `config.toml` to the real deployment domain before publishing.

## Conversion notes

- Org headings `*` became Markdown `##` (the page title is rendered separately
  as the `<h1>`).
- Org emphasis (`/italic/`, `*bold*`) became `*italic*` / `**bold**`.
- `[[url][text]]` links became `[text](url)`; `=code=` became `` `code` ``.
- Org `#+begin_quote` blocks became Markdown blockquotes.
- Org tables became Markdown tables; the caption is an italic paragraph.
- Org footnotes `[fn:N]` became Markdown footnotes `[^N]`.
- `org-cite` `[cite:@key]` citations became footnotes pointing at the
  bibliography entries (`[^slikts]`, `[^vanroy]`).
- Figures are plain `<figure>` blocks so the captions are preserved.
- The auto-generated `sitemap.org` was replaced by the posts section listing
  (`content/posts/_index.md` + `templates/section.html`).

## Sitemap & blog index

Zola generates both automatically, no plugins needed:

- **`/sitemap.xml`** — machine-readable sitemap of every page, controlled by
  `generate_sitemap = true` in `config.toml` (also generates `/robots.txt`).
- **`/posts/`** — the blog index, driven by `content/posts/_index.md`
  (`sort_by = "date"`) and rendered with `templates/section.html`.
- **`/sitemap/`** — a human-readable sitemap listing all pages and posts,
  built from `content/sitemap.md` + `templates/sitemap.html`.
- The home page also shows the 5 most recent posts.
