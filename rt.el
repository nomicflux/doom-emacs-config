;;; $DOOMDIR/rt.el -*- lexical-binding: t; -*-
;;;

(require 'doom-themes)

(setq light-themes '(doom-flatwhite
                     doom-gruvbox-light
                     doom-nord-light
                     doom-opera-light
                     doom-solarized-light
                     tao-yang))

(setq dark-themes '(doom-Iosevkm
                    doom-fairy-floss
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

(defun random-doom-theme (&optional themes)
  (interactive)
  (let* ((ts (if themes themes (append dark-themes light-themes)))
         (n (random (length ts)))
         (theme (nth n ts)))
    (progn
      (disable-theme doom-theme)
      (load-theme theme t))))

(defun random-light-theme ()
  (interactive)
  (random-doom-theme light-themes))

(defun random-dark-theme ()
  (interactive)
  (random-doom-theme dark-themes))

(defun add-themes ()
  (map! :leader
        (:prefix "t"
         :desc "Random Doom theme" "s" 'random-doom-theme
         :desc "Random Dark Doom theme" "t" 'random-dark-theme
         :desc "Random Light Doom theme" "T" 'random-light-theme)))

(load-theme 'doom-nord)
