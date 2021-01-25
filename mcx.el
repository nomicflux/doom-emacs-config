;;; $DOOMDIR/mcx.el -*- lexical-binding: t; -*-

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
