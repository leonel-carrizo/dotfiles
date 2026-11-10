# ⚙️ Dotfiles

Personal dotfiles and system configuration files for my development and desktop environments — primarily used on **Linux** (Arch-based). Includes settings for i3wm, Qtile, Neovim, terminals, and various utilities and scripts.
> Feel free to fork, adapt, or contribute ideas via issues or pull requests.
> 
---

## 📆 Included Tools & Configs

* **Window Managers**: i3wm, Qtile
* **Terminal Emulators**: Alacritty, Kitty
* **Editor**: Neovim (LazyVim, NvChad, 42-style)
* **Notification Daemon**: Dunst.
* **Lockscreen & Logout**: Betterlockscreen, Wlogout.
* **Compositor & Wallpaper**: Picom, Nitrogen
* **File manager**: Ranger
* **Other tools**: Neofetch, libinput gestures, etc.

---

## 🔗 Installation (Manual Symlinks)

There’s no install script yet. To use these configs, manually create symbolic links from this repository to your system’s config directories.

### Example:

```bash
# Set Neovim config
ln -s ~/dotfiles/my_nvim ~/.config/nvim

# Set i3 and Kitty configs
ln -s ~/dotfiles/i3 ~/.config/i3
ln -s ~/dotfiles/kitty ~/.config/kitty
```

> ⚠️ Always back up your existing configs before linking.

---

## 🎮 Plymouth Theme: `archGrey`

Located in the `archGrey/` folder — this is a custom animated **Plymouth boot splash**. To install:

```bash
sudo cp -r archGrey /usr/share/plymouth/themes/
sudo plymouth-set-default-theme archGrey -R
```

---

## 🧰 Useful Scripts (`bin/`)

* `capture`, `capture-full`: screenshots.
* `update_lockscreenbg`: update lockscreen background.
* `kb-layout`: keyboard layout switch.-
* `lazy_git`: shortcut for lazygit.-
* `42norm_format`: formatter for 42-school style
* `vbox-secureboot`: install, repair and verify VirtualBox kernel module signing with Secure Boot (Fedora, needs root).

Add `bin/` to your `$PATH` or symlink the individual scripts if needed.

---

## 🧪 Misc / Utilities

* `markdownlint`, `vale/`: writing lint/style tools
* `libinput-gestures.conf`: touchpad gesture settings
* `reset-styles.css`: global stylesheet
* `autostart/`: session startup entries
* `config.conf`, `pavucontrol.ini`: misc system/user settings

---

## 💻 Compatibility

✅ Tested on **Linux (Arch)**
❌ Not tested on macOS or Windows — may require adaptation.

---
![License: MIT](https://img.shields.io/badge/license-MIT-blue)  © Leonel Carrizo

![Maintained with ❤️](https://img.shields.io/badge/maintained%20with-love-red)
