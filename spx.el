;;; $DOOMDIR/spx.el -*- lexical-binding: t; -*-

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
(def-sp-alternatives "next-sexp")
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
         :desc "contract region" "E" 'er/contract-region
         :desc "slurp forward" "f" 'sp-forward-slurp-sexp
         :desc "barf forward" "F" 'sp-forward-barf-sexp
         :desc "slurp backward" "b" 'sp-backward-slurp-sexp
         :desc "barf backward" "B" 'sp-backward-barf-sexp
         :desc "up sexp" "u" 'sp-up-sexp
         :desc "backward down sexp" "d" 'sp-backward-down-sexp
         :desc "backward up sexp" "U" 'sp-backward-up-sexp
         :desc "down sexp" "D" 'sp-down-sexp
         :desc "next sexp" "n" 'sp-next-sexp
         :desc "next surrounding sexp" "N" 'spx/with-surrounding-next-sexp
         :desc "previous sexp" "h" 'sp-backward-parallel-sexp
         :desc "previous surrounding sexp" "H" 'spx/with-surrounding-backward-parallel-sexp
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
