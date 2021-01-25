;;; $DOOMDIR/rt.el -*- lexical-binding: t; -*-

(defun random-theme ()
  (interactive)
  (let* ((num-themes (length custom-known-themes))
         (n (random num-themes))
         (theme (nth n custom-known-themes)))
    (progn (load-theme theme))))

(defun add-themes ()
  (map! :leader
        (:prefix "t"
         :desc "Random theme" "t" 'random-theme)))
