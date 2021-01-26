;;; $DOOMDIR/rt.el -*- lexical-binding: t; -*-
;;;

(require 'seq)
(require 'doom-themes)

(setq rt-light-themes '(doom-flatwhite
                        doom-gruvbox-light
                        doom-nord-light
                        doom-opera-light
                        doom-solarized-light
                        tao-yang))

(setq rt-dark-themes '(doom-fairy-floss
                       doom-gruvbox
                       doom-molokai
                       doom-monokai-spectrum
                       doom-moonlight
                       doom-nord
                       doom-nova
                       doom-oceanic-next
                       doom-solarized-dark
                       doom-spacegrey
                       doom-wilmersdorf
                       doom-zenburn
                       tao-yin))

(defun not-current-theme-p (theme)
  (not (eq doom-theme theme)))

(defun rt-random-doom-theme (&optional themes)
  (interactive)
  (let* ((ts (seq-filter 'not-current-theme-p (or themes (append rt-dark-themes rt-light-themes))))
         (n (random (length ts)))
         (theme (nth n ts)))
    (progn
      (disable-theme doom-theme)
      (load-theme theme t))))

(defun rt-random-light-theme ()
  (interactive)
  (rt-random-doom-theme rt-light-themes))

(defun rt-random-dark-theme ()
  (interactive)
  (rt-random-doom-theme rt-dark-themes))

(setq rt-random-theme-change-freq (* 60 10))
(setq rt-random-theme-change-timer nil)

(defun rt-stop-randomly-changing-theme* ()
  (when rt-random-theme-change-timer
      (cancel-timer rt-random-theme-change-timer)))

(defun rt-start-randomly-changing-theme* ()
  (when (bound-and-true-p rt-random-theme-change-mode)
    (progn (rt-random-doom-theme)
           (setq rt-random-theme-change-timer
                (run-with-timer rt-random-theme-change-freq nil 'rt-start-randomly-changing-theme*)))))

(define-minor-mode rt-random-theme-change-mode
  "Randomly change themes at a set interval"
  :lighter " rt"
  :global t)

(defun rt-stop-randomly-changing-theme ()
  (interactive)
  (rt-random-theme-change-mode nil)
  (rt-stop-randomly-changing-theme*))

(defun rt-start-randomly-changing-theme ()
  (interactive)
  (rt-random-theme-change-mode 1)
  (rt-start-randomly-changing-theme*))

(defun add-themes ()
  (map! :leader
        (:prefix "t"
         :desc "Random Doom theme" "s" 'rt-random-doom-theme
         :desc "Random Dark Doom theme" "t" 'rt-random-dark-theme
         :desc "Random Light Doom theme" "T" 'rt-random-light-theme
         :desc "Randomly change themes" "R" 'rt-start-randomly-changing-theme
         :desc "Stop randomly changing themes" "Q" 'rt-stop-randomly-changing-theme)))
