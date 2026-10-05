# artiombn's Blog

This is a personal blog website using the [Zola](https://www.getzola.org/) SSG.

## Usage

Make sure to create the symlinks to the built games,
such as the symlink to the `arcade-megamix` game inside `/static/games/arcade-megamix`.

```sh
# Build into ./public
zola build

# Preview at http://127.0.0.1:1111
zola serve

# Check internal links (external 403s from StackOverflow/ResearchGate are expected)
zola check
```

Set `base_url` in `config.toml` to the real deployment domain before publishing.
