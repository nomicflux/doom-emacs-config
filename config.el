;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Michael Anderson"
      user-mail-address "manderson@drwholdings.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-wilmersdorf)
(setq doom-font (font-spec :family "Iosevka" :size 14 :weight 'light))
(setq doom-big-font (font-spec :family "Iosevka" :size 18 :weight 'light))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(require 'flycheck)
(require 'evil-snipe)
(require 'evil-easymotion)
(require 'writeroom-mode)

(load! "spx.el")
(load! "mcx.el")
(load! "rt.el")
(load! "clojure.el")

(defun configure-test-toggle ()
  (map! :leader
        (:prefix "c"
         :desc "Jump to test" "T" 'projectile-toggle-between-implementation-and-test)))

;; (defun nf/coding-mode ()
;;                 (interactive)
;;                 (cond ((bound-and-true-p writeroom-mode)
;;                        (writeroom-mode -1)
;;                        (toggle-frame-fullscreen))
;;                       (t
;;                         (writeroom-mode 1)
;;                         (toggle-frame-fullscreen))))
;;


;;https://github.com/joostkremers/writeroom-mode#fullscreen-effect
(setq writeroom-fullscreen-effect 'fullboth)

(setq git-commit-summary-max-length 80)
(add-hook 'clojure-mode-hook 'clojure-mode-setup)
(configure-smartparens)
(configure-multiple-cursors)
(configure-test-toggle)
(add-themes)
(toggle-frame-fullscreen)
