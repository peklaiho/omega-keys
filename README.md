# Ω Keys

Omega Keys is a global minor mode for Emacs that provides modal editing using customized keys.

It is similar to [Evil](https://github.com/emacs-evil/evil), but instead of using Vim keys, it uses <kbd>i</kbd>, <kbd>j</kbd>, <kbd>k</kbd> and <kbd>l</kbd> keys for moving around. In my opinion this is more natural for someone not used to Vim because the physical layout of the keys is similar to normal arrow keys.

## Installation

For now just download the [omega-keys.el](omega-keys.el) file and put it somewhere on your computer. I will try to get this on [MELPA](https://melpa.org/) later for easy installation.

## Configuration

I recommend the keybinding <kbd>M-j</kbd> for enabling Omega Keys. Minimal configuration with [use-package](https://www.gnu.org/software/emacs/manual/html_mono/use-package.html) could look something like this:

```elisp
(use-package omega-keys
  :demand t
  :load-path "~/.emacs.d/myPackages/omega-keys"
  :after ido
  :bind (("M-j" . omega-keys-enable))
  :config
  (global-omega-keys-mode t))
```

Obviously change the `:load-path` to reflect the directory where you put the `omega-keys.el` file. If you use [Ido](https://www.gnu.org/software/emacs/manual/html_mono/ido.html) make sure it is loaded first (the `:after ido` part) because then Omega Keys knows to use Ido-versions of some functions. The `(global-omega-keys-mode t)` at the end enables Omega Keys by default in new buffers.

Personally I also like to use <kbd>M-q</kbd> for aborting an ongoing action instead of the Emacs default <kbd>C-g</kbd> because I think it is much more convenient keybinding for my fingers. With that in mind, the `:bind` section could look something like this:

```elisp
(("M-j" . omega-keys-enable)
 ("M-q" . keyboard-quit)
 :map minibuffer-local-map
 ("M-q" . abort-recursive-edit)
 :map query-replace-map
 ("M-q" . quit))
```

In practice you should probably define much more personalized keybindings depending on which packages you are using to enhance the default Emacs features. For example, I am using [Swiper](https://github.com/abo-abo/swiper) for searching instead of *isearch* and so on.

There is also a separate keymap `omega-keys-custom-map` for defining keys for your own custom functions. It is activated from <kbd>c</kbd> when Omega Keys is enabled.

### Cursor

Omega Keys can change the cursor type depending on whether the mode is enabled or disabled. This makes it more easy to know which mode you are in. The customizable variable `omega-keys-cursor-type` defines the cursor to use when the mode is enabled. Setting it to `nil` disables the changing of cursors. See the built-in `cursor-type` for possible values to use. It defaults to `t`.

I set my default cursor to narrow bar in my init file that is used when Omega Keys is not active:

```elisp
(setq-default cursor-type '(bar . 2))
```

## Usage

Changing modes:

* Use <kbd>f</kbd> to disable Omega Keys ("activate edit mode")
* Use <kbd>M-j</kbd> to enable Omega Keys ("activate command mode")

Omega Keys consists of three "layers" of keys:

1. Simple keys without modifiers from <kbd>a</kbd> to <kbd>z</kbd>.
1. Meta keys from <kbd>M-a</kbd> to <kbd>M-z</kbd>. They are generally "stronger" versions of the simple keys. For example <kbd>l</kbd> moves forward by one character while <kbd>M-l</kbd> moves forward by one word. Omega Keys only binds about half of the Meta keys from a-z, so the other half will be bound to Emacs defaults.
1. Extended keys defined in `omega-keys-extended-map` and activated by pressing the <kbd>x</kbd> key. Extended keys are used to save file (<kbd>x</kbd><kbd>s</kbd>), open file (<kbd>x</kbd><kbd>f</kbd>) or exit emacs (<kbd>x</kbd><kbd>q</kbd>) for example.

I do not want to list the complete keymaps here in the README file because the code is very short and readable, so duplicating everything in the README would be redundant. Please see the [code](omega-keys.el) instead for all the keys.

## Etymology

Omega is the final character of the Greek alphabet. The name implies that Omega Keys is the final key configuration you need to learn in order to be really efficient and productive with a text editor.
