;;; $DOOMDIR/rt.el -*- lexical-binding: t; -*-
;;;

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

(defun rt-random-doom-theme (&optional themes)
  (interactive)
  (let* ((ts (or themes (append rt-dark-themes rt-light-themes)))
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

(defun add-themes ()
  (map! :leader
        (:prefix "t"
         :desc "Random Doom theme" "s" 'rt-random-doom-theme
         :desc "Random Dark Doom theme" "t" 'rt-random-dark-theme
         :desc "Random Light Doom theme" "T" 'rt-random-light-theme)))

(setq rt-random-theme-change-freq (* 5 1))
(setq rt-random-theme-change-timer nil)

(defun rt-randomly-change-theme ()
  (when (bound-and-true-p rt-random-theme-change-mode)
    (rt-random-doom-theme))
  (if (bound-and-true-p rt-random-theme-change-mode)
      (setq rt-random-theme-change-timer
            (run-with-timer rt-random-theme-change-freq nil 'rt-randomly-change-theme))
    (when rt-random-theme-change-timer
      (cancel-timer rt-random-theme-change-timer))))

(define-minor-mode rt-random-theme-change-mode
  "Randomly change themes at a set interval"
  :lighter " rt"
  :global t)
  ;; :after-hook 'randomly-change-theme)

(add-hook 'rt-random-theme-change-mode-hook 'rt-randomly-change-theme)

;; (rt-randomly-change-theme*)
