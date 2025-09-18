# Nord Deep

> An arctic, north-bluish color palette taken to deeper depths.

Nord Deep shifts the original [Nord][nord] palette deeper while preserving its
proven relationships and pastel aesthetic. Enhanced contrast for better
accessibility, clearer UI hierarchy, and more flexible theming across modern
development environments.

## Philosophy

**Why deeper?** Modern screens and development tools benefit from increased
contrast without sacrificing Nord's calming, muted character. Nord Deep
maintains the relationships that make Nord work while providing:

- **Better accessibility** - Improved contrast ratios for text readability
- **Clearer hierarchy** - More distinct levels for complex UI layouts
- **Enhanced focus** - Deeper background reduces visual noise

## Color Palettes

Nord Deep consists of four named color palettes providing different syntactic
meanings and color effects.

### Polar Night

_Foundation colors for UI structure_

| Color                                                        | Name          | Hex       | Usage                                |
| ------------------------------------------------------------ | ------------- | --------- | ------------------------------------ |
| <img src="assets/nord_base.png" height="16" width="16"/>     | nord-base     | `#212732` | Primary backgrounds (default bg)     |
| <img src="assets/nord_surface.png" height="16" width="16"/>  | nord-surface  | `#2e3440` | Elevated surfaces                    |
| <img src="assets/nord_elevated.png" height="16" width="16"/> | nord-elevated | `#3b4252` | Interactive chrome, terminal: color0 |
| <img src="assets/nord_subtle.png" height="16" width="16"/>   | nord-subtle   | `#434c5e` | Subtle indicators, terminal: color8  |

### Snow Storm

_Text hierarchy from subtle to prominent_

| Color                                                      | Name        | Hex       | Usage                                          |
| ---------------------------------------------------------- | ----------- | --------- | ---------------------------------------------- |
| <img src="assets/nord_dim.png" height="16" width="16"/>    | nord-dim    | `#798094` | Disabled, comments                             |
| <img src="assets/nord_text.png" height="16" width="16"/>   | nord-text   | `#b8c5d1` | Primary content (default fg), terminal: color7 |
| <img src="assets/nord_bright.png" height="16" width="16"/> | nord-bright | `#d4dce6` | Emphasis, headings, terminal: color15          |

### Frost

_Structural syntax highlighting colors_

The Frost palette remains **unchanged from original [Nord][nord]** to preserve
the proven syntax highlighting aesthetic.

| Color                                                    | Name      | Hex       | Usage                                          |
| -------------------------------------------------------- | --------- | --------- | ---------------------------------------------- |
| <img src="assets/nord_aqua.png" height="16" width="16"/> | nord-aqua | `#8fbcbb` | Types, classes                                 |
| <img src="assets/nord_cyan.png" height="16" width="16"/> | nord-cyan | `#88c0d0` | Functions, links, terminal: color6, color14    |
| <img src="assets/nord_blue.png" height="16" width="16"/> | nord-blue | `#81a1c1` | Keywords, operators, terminal: color4, color12 |
| <img src="assets/nord_navy.png" height="16" width="16"/> | nord-navy | `#5e81ac` | Characters, hints                              |

### Aurora

_Semantic syntax highlighting colors_

The Aurora palette remains **unchanged from original [Nord][nord]** to preserve
the proven syntax highlighting aesthetic.

| Color                                                       | Name         | Hex       | Usage                                       |
| ----------------------------------------------------------- | ------------ | --------- | ------------------------------------------- |
| <img src="assets/nord_red.png" height="16" width="16"/>     | nord-red     | `#bf616a` | Errors, deletions, terminal: color1, color9 |
| <img src="assets/nord_orange.png" height="16" width="16"/>  | nord-orange  | `#d08770` | Special highlights, TODO tags, etc          |
| <img src="assets/nord_yellow.png" height="16" width="16"/>  | nord-yellow  | `#ebcb8b` | Warnings, regex, terminal: color3, color11  |
| <img src="assets/nord_green.png" height="16" width="16"/>   | nord-green   | `#a3be8c` | Strings, success, terminal: color2, color10 |
| <img src="assets/nord_magenta.png" height="16" width="16"/> | nord-magenta | `#b48ead` | Numbers, symbols, terminal: color5, color13 |

## Design Principles

### Flexible UI Hierarchy

The Polar Night palette provides a 4-level foundation adaptable to any
application architecture:

**Information Architecture:**

- **Primary workspace** (nord-base) - main content, editor background
- **Elevated surfaces** (nord-surface) - panels, secondary areas
- **Interactive chrome** (nord-elevated) - status bars, active states
- **Subtle indicators** (nord-subtle) - borders, guides, hover states

**Key Principle:** Layer intentionally based on information priority, not rigid
rules.

### Transparency and Layering

- **Subtle highlights:** Use transparency like `#2e344080` (50% opacity) for
  active lines, wrap guides, indent guides, etc...
- **Fallback option:** Blended result `#282e39` when transparency unavailable
- **Alternative:** Use intermediate colors like `nord-surface` for middle ground

### Implementation Examples

**Editor UI Hierarchy:**

```jsonc
{
  "editor.background": "#212732", // Primary workspace
  "panel.background": "#2e3440", // Elevated panels
  "status_bar.background": "#3b4252", // Interactive chrome
  "editor.active_line.background": "#2e344080", // Subtle highlight
  "tab.inactive_background": "#2e3440", // Secondary surfaces
  "pane_group.border": "#3b4252", // Structural separation
}
```

**Terminal Setup:**

```ini
background = #212732
foreground = #b8c5d1
selection_background = #3b4252
cursor = #b8c5d1
```

This creates clear information architecture: **workspace < panels < chrome**
with intentional transparency for active states.

---

[nord]: https://www.nordtheme.com/docs/colors-and-palettes
