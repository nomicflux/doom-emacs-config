;;; $DOOMDIR/clojure.el -*- lexical-binding: t; -*-

(defun clojure-save-hook ()
  (when (and (cider-connected-p)
           (string= "(ns " (buffer-substring-no-properties 1 5))
           (string-match "\\.clj.?$" (buffer-name)))
    (cider-load-buffer)
    (cider-ns-refresh)))

(defun clojure-mode-setup ()
  (require 'flycheck-clj-kondo)
  ;; (require 'flycheck-joker)
  (require 'clj-refactor)
  (dolist (checker '(clj-kondo-clj clj-kondo-cljs clj-kondo-cljc clj-kondo-edn))
    (setq flycheck-checkers (cons checker (delq checker flycheck-checkers))))
  ;; (dolist (checkers '((clj-kondo-clj . clojure-joker)
  ;;                     (clj-kondo-cljs . clojurescript-joker)
  ;;                     (clj-kondo-cljc . clojure-joker)
  ;;                     (clj-kondo-edn . edn-joker)))
  ;;   (flycheck-add-next-checker (car checkers) (cons 'error (cdr checkers))))
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import statements
  (add-hook 'after-save-hook 'clojure-save-hook)
  (add-hook 'find-file-hook 'cider-load-buffer)
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-R"))

(add-to-list 'auto-mode-alist '("\\.cljx\\'" . clojure-mode))

(add-hook 'clojure-mode-hook 'clojure-mode-setup)
(setq cider-test-show-report-on-success t)
