# Overriders 🚀

A curated collection of customized shell override plugins for [Omarchy Linux](https://omarchy.org/) (Hyprland + Quickshell).

These plugins override Omarchy's core bar and status widgets to deliver enhanced visuals, tailored font sizes, idle celebration animations, and refined interaction workflows.

---

## 📦 Included Plugins

### 1. 🌟 My Bar (`zm.bar`)
- **Cloned From**: `omarchy.bar`
- **Features**:
  - **Bar Celebrate Mode**: Built-in support for flashing bar icons with dynamic, rapid random bright colors upon system idle, followed by a soothing post-celebrate gray transition.
  - **Multi-Vector Instant Wake**: Immediate restoration to normal theme colors upon mouse move (`hyprctl cursorpos`), keypress, window focus change, workspace switch, or bar hover.
  - **First-Party Theming & Opacity**: Dynamic bindings for widget foreground colors, transparency handling, and corner styling (`regular` or `concave`).

### 2. 🕒 My Clock (`zm.clock`)
- **Cloned From**: `omarchy.clock`
- **Features**:
  - **Refined Typography**: Adjusted font size to **16px** for balanced status bar legibility.
  - **Format Support**: Supports custom vertical (`HH\nmm`) and horizontal (`HH:mm`) formats with ISO week calculation.
  - **Integrated Calendar Popup**: Left-click opens full monthly calendar and upcoming events panel.
  - **Timezone Picker**: Middle-click launches Omarchy's timezone switcher (`omarchy-menu-timezone`).
  - **Cycle Formats**: Right-click cycles through common time and date formats on the fly.

### 3. 🗂️ My Workspaces (`zm.workspaces`)
- **Cloned From**: `omarchy.workspaces`
- **Features**:
  - **Workspace Dynamic Range**: Intelligently renders workspaces 1 through 10 as needed.
  - **Visual Indicator**: Highlights active workspace with a custom icon (`󰻻`), with distinct opacity levels for occupied vs. empty workspaces.
  - **Mouse Wheel Navigation**: Scroll on the widget to switch between workspaces effortlessly.

---

## 🚀 Installation

Clone the repository to your machine:

```bash
git clone https://github.com/zmata535-dev/Overriders.git ~/Overriders
```

### Option A: Automatic Setup Script

Run `install.sh` to symlink the plugins into `~/.config/omarchy/plugins/`:

```bash
cd ~/Overriders
./install.sh
```

*(To copy files instead of symlinking, run `./install.sh copy`)*

### Option B: Manual Installation

Symlink or copy each plugin directory into `~/.config/omarchy/plugins/`:

```bash
ln -s ~/Overriders/zm.bar ~/.config/omarchy/plugins/zm.bar
ln -s ~/Overriders/zm.clock ~/.config/omarchy/plugins/zm.clock
ln -s ~/Overriders/zm.workspaces ~/.config/omarchy/plugins/zm.workspaces

omarchy restart shell
```

---

## ⚙️ Configuration (`shell.json`)

To use these override plugins in your status bar, update `~/.config/omarchy/shell.json`:

```json
{
  "bar": {
    "id": "zm.bar",
    "position": "left",
    "transparent": true,
    "layout": {
      "left": [
        { "id": "zm.clock", "format": "HH:mm", "verticalFormat": "HH\nmm" }
      ],
      "center": [
        { "id": "zm.workspaces" }
      ],
      "right": [
        { "id": "omarchy.tray" }
      ]
    }
  }
}
```

---

## 📄 License

[MIT](LICENSE) © 2026 [zmata535-dev](https://github.com/zmata535-dev)
