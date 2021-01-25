;;; $DOOMDIR/rt.el -*- lexical-binding: t; -*-
;;;

(require 'seq)
(require 'doom-themes)

(defun doom-theme-p (theme-name)
  (string-prefix-p "doom-" (symbol-name theme-name)))

(defun random-doom-theme ()
  (interactive)
  (let* ((doom-themes (seq-filter 'doom-theme-p custom-known-themes))
         (num-themes (length doom-themes))
         (n (random num-themes))
         (theme (nth n doom-themes)))
    (progn
      (disable-theme doom-theme)
      (load-theme theme t))))

(defun add-themes ()
  (map! :leader
        (:prefix "t"
         :desc "Random Doom theme" "t" 'random-doom-theme)))
