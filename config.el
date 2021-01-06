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

(defmacro def-wrap-surrounding (name)
  `(defun ,(read (concat "spx/wrap-surrounding-" name))
       (&optional arg)
     (interactive "p")
     (list (sp-backward-up-sexp)
           (,(read (concat "sp-wrap-" name))))))

(def-wrap-surrounding "round")
(def-wrap-surrounding "square")
(def-wrap-surrounding "curly")

(defun configure-smartparens ()
  (map! :leader
        (:prefix ("k" . "smartparens")
         :desc "wrap with parentheses" "(" 'sp-wrap-round
         :desc "wrap surrounding with parentheses" ")" 'spx/wrap-surrounding-round
         :desc "wrap with brackets" "[" 'sp-wrap-square
         :desc "wrap surrounding with brackets" "]" 'spx/wrap-surrounding-square
         :desc "wrap with braces" "{" 'sp-wrap-curly
         :desc "wrap surrounding with braces" "}" 'spx/wrap-surrounding-curly
         :desc "slurp forward" "f" 'sp-forward-slurp-sexp
         :desc "barf forward" "F" 'sp-forward-barf-sexp
         :desc "slurp backward" "b" 'sp-backward-slurp-sexp
         :desc "barf backward" "b" 'sp-backward-barf-sexp
         (:prefix ("w" . "Wrap")
          :desc "Backticks" "`" 'sp-wrap-backtick
          :desc "Tildes" "~" 'sp-wrap-tilde
          ))))

(configure-smartparens)

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



