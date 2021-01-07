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
(setq doom-theme 'doom-gruvbox)
(setq doom-font (font-spec :family "Iosevka Term" :size 16 :weight 'light))

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

(defmacro def-sp-alternatives (name)
  (let ((surr-name (concat "spx/with-surrounding-" name))
        (orig-name (concat "sp-" name))
        (i-name (concat "spx/" name "-i")))
    `(progn
       (defun ,(read surr-name)
           (&optional arg)
         (interactive)
         (sp-backward-up-sexp)
         (,(read orig-name)))
       (defun ,(read (concat surr-name "-i"))
           (&optional arg)
         (interactive)
         (,(read surr-name))
         (call-interactively #'evil-insert))
       (defun ,(read i-name)
           (&optional arg)
         (interactive)
         (,(read orig-name))
         (call-interactively #'evil-insert)))))

(def-sp-alternatives "wrap-round")
(def-sp-alternatives "wrap-square")
(def-sp-alternatives "wrap-curly")
(def-sp-alternatives "kill-sexp")
(def-sp-alternatives "copy-sexp")
(def-sp-alternatives "transpose-sexp")
(def-sp-alternatives "unwrap-sexp")
(def-sp-alternatives "splice-sexp")
(def-sp-alternatives "splice-sexp-killing-around")
(def-sp-alternatives "forward-parallel-sexp")
(def-sp-alternatives "backward-parallel-sexp")
(def-sp-alternatives "beginning-of-sexp")
(def-sp-alternatives "end-of-sexp")

(defun spx/select-surrounding (&optional arg)
  (interactive)
  (sp-backward-up-sexp)
  (sp-select-next-thing))

(defun configure-smartparens ()
  (map! :leader
        (:prefix ("k" . "smartparens")
         :desc "wrap with parens" "(" 'sp-wrap-round
         :desc "surround with parens" ")" 'spx/with-surrounding-wrap-round
         :desc "wrap with brackets" "[" 'sp-wrap-square
         :desc "surround with brackets" "]" 'spx/with-surrounding-wrap-square
         :desc "wrap with braces" "{" 'sp-wrap-curly
         :desc "surround with braces" "}" 'spx/with-surrounding-wrap-curly
         :desc "convolute" "c" 'sp-convolute-sexp
         :desc "swap" "C" 'sp-swap-enclosing-sexp
         :desc "expand region" "e" 'er/expand-region
         :desc "slurp forward" "f" 'sp-forward-slurp-sexp
         :desc "barf forward" "F" 'sp-forward-barf-sexp
         :desc "slurp backward" "b" 'sp-backward-slurp-sexp
         :desc "barf backward" "b" 'sp-backward-barf-sexp
         :desc "up sexp" "u" 'sp-up-sexp
         :desc "backward down sexp" "d" 'sp-backward-down-sexp
         :desc "backward up sexp" "U" 'sp-backward-up-sexp
         :desc "down sexp" "D" 'sp-down-sexp
         :desc "next sexp" "n" 'sp-forward-parallel-sexp
         :desc "previous sexp" "h" 'sp-backward-parallel-sexp
         :desc "next surrounding sexp" "n" 'spx/with-surrounding-forward-parallel-sexp
         :desc "previous surrounding sexp" "h" 'spx/with-surrounding-backward-parallel-sexp
         :desc "kill" "k" 'sp-kill-sexp
         :desc "kill surrounding" "K" 'spx/with-surrounding-kill-sexp
         :desc "yank" "y" 'sp-copy-sexp
         :desc "yank surrounding" "Y" 'spx/with-surrounding-copy-sexp
         :desc "select surrounding" "S" 'spx/select-surrounding
         :desc "transpose" "t" 'sp-transpose-sexp
         :desc "transpose surrounding" "T" 'spx/with-surrounding-transpose-sexp
         :desc "unwrap" "-" 'sp-unwrap-sexp
         :desc "unwrap surrounding" "_" 'spx/with-surrounding-unwrap-sexp
         :desc "beginning of sexp" ";" 'sp-beginning-of-sexp
         :desc "beginning of surrounding sexp" ":" 'spx/with-surrounding-beginning-of-sexp
         :desc "end of sexp" "z" 'sp-end-of-sexp
         :desc "end of surrounding sexp" "Z" 'spx/with-surrounding-end-of-sexp
         (:prefix ("i" . "insert")
          :desc "wrap with parens" "(" 'spx/wrap-round-i
          :desc "surround with parens" ")" 'spx/with-surrounding-wrap-round-i
          :desc "wrap with brackets" "[" 'spx/wrap-square-i
          :desc "surround with brackets" "]" 'spx/with-surrounding-wrap-square-i
          :desc "wrap with braces" "{" 'spx/wrap-curly-i
          :desc "surround with braces" "}" 'spx/with-surrounding-wrap-curly-i
          :desc "kill" "k" 'spx/kill-sexp-i
          :desc "kill surrounding" "K" 'spx/with-surrounding-kill-sexp-i
          :desc "yank" "y" 'spx/copy-sexp-i
          :desc "yank surrounding" "Y" 'spx/with-surrounding-copy-sexp-i
          :desc "beginning of sexp" ";" 'spx/beginning-of-sexp-i
          :desc "beginning of surrounding sexp" ":" 'spx/with-surrounding-beginning-of-sexp-i
          :desc "end of sexp" "z" 'spx/end-of-sexp-i
          :desc "end of surrounding sexp" "Z" 'spx/with-surrounding-end-of-sexp-i)
         (:prefix ("s" . "splice")
          :desc "sexp" "s" 'sp-splice-sexp
          :desc "sexp surrounding" "S" 'spx/with-surrounding-splice-sexp
          :desc "around" "a" 'sp-splice-sexp-killing-around
          :desc "around surrounding" "A" 'spx/with-surrounding-splice-sexp-killing-around
          :desc "forward" "f" 'sp-splice-sexp-killing-forward
          :desc "backward" "b" 'sp-splice-sexp-killing-backward))))

(defun configure-multiple-cursors ()
  (map! :leader
        (:prefix ("j" . "multiple-cursors")
         :desc "edit lines" "e" 'mc/edit-lines
         :desc "mark" "m" 'mc/mark-all-like-this-in-defun
         :desc "mark all" "M" 'mc/mark-all-like-this
         :desc "syms in defun" "s" 'mc/mark-all-symbols-like-this-in-defun
         :desc "all syms" "S" 'mc/mark-all-symbols-like-this
         :desc "words in defun" "w" 'mc/mark-all-words-like-this-in-defun
         :desc "all words" "W" 'mc/mark-all-words-like-this
         :desc "next" "n" 'mc/mark-next-like-this
         :desc "next word" "N" 'mc/mark-next-like-this-word
         :desc "prev" "h" 'mc/mark-previous-like-this
         :desc "prev word" "H" 'mc/mark-previous-like-this-word
         :desc "vertical align" "a" 'mc/vertical-align
         :desc "mark tag pair" "t" 'mc/mark-sgml-tag-pair
         :desc "pop" "p" 'mc/mark-pop
         :desc "unmark next" "u" 'mc/unmark-next-like-this
         :desc "skip to next" "U" 'mc/skip-to-next-like-this
         :desc "unmark previous" "v" 'mc/unmark-previous-like-this
         :desc "skip to previous" "V" 'mc/skip-to-previous-like-this
         :desc "quit" "q" 'mc/keyboard-quit)))

(configure-smartparens)
(configure-multiple-cursors)

(defun clojure-mode-setup ()
  (require 'clj-refactor)
  (require 'flyncheck-clj-kondo)
  (require 'flycheck-joker)
  (dolist (checker '(clj-kondo-clj clj-kondo-cljs clj-kondo-cljc clj-kondo-edn))
    (setq flycheck-checkers (cons checker (delq checker flycheck-checkers))))
  (dolist (checkers '((clj-kondo-clj . clojure-joker)
                      (clj-kondo-cljs . clojurescript-joker)
                      (clj-kondo-cljc . clojure-joker)
                      (clj-kondo-edn . edn-joker)))
    (flycheck-add-next-checker (car checkers) (cons 'error (cdr checkers)))))

(add-hook 'clojure-mode-hook 'clojure-mode-setup) 



