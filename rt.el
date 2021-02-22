;;; $DOOMDIR/rt.el -*- lexical-binding: t; -*-
;;;

(require 'seq)
(require 'doom-themes)

(setq rt-light-themes '(doom-flatwhite
                        doom-gruvbox-light
                        doom-nord-light
                        doom-one-light
                        doom-opera-light
                        doom-solarized-light
                        doom-tomorrow-day
                        tao-yang))

(setq rt-dark-themes '(doom-challenger-deep
                       doom-city-lights
                       doom-fairy-floss
                       doom-gruvbox
                       doom-laserwave
                       doom-miramare
                       doom-molokai
                       doom-monokai-spectrum
                       doom-moonlight
                       doom-nord
                       doom-nova
                       doom-oceanic-next
                       doom-palenight
                       doom-solarized-dark
                       doom-spacegrey
                       doom-tomorrow-night
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
(setq rt-random-theme-change-type 'both)
(setq rt-random-theme-change-timer nil)

(defun rt-stop-randomly-changing-theme* ()
  (when rt-random-theme-change-timer
      (cancel-timer rt-random-theme-change-timer)))

(defun rt-start-randomly-changing-theme* ()
  (when (bound-and-true-p rt-random-theme-change-mode)
    (progn (rt-random-doom-theme (cond ((and rt-random-theme-change-type
                                             (eq rt-random-theme-change-type 'dark))
                                        rt-dark-themes)
                                       ((and rt-random-theme-change-type
                                             (eq rt-random-theme-change-type 'light))
                                        rt-light-themes)
                                       (t nil)))
           (when rt-random-theme-change-timer (rt-stop-randomly-changing-theme*))
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

(defun rt-change-random-theme-freq (n)
  (interactive "nMinutes between changes: ")
  (setq rt-random-theme-change-freq (* 60 n)))

(defun rt-change-random-theme-type (c)
  (interactive "c(d)ark, (l)ight, or (b)oth themes: ")
  (cond ((eq c ?d) (setq rt-random-theme-change-type 'dark))
        ((eq c ?l) (setq rt-random-theme-change-type 'light))
        (t (setq rt-random-theme-change-type 'both))))

(defun subtract-time (h m s)
  (let ((nm (- m s)))
    (if (< nm 0)
        (list (- h 1) (+ nm 60))
      (list h nm))))

(defun time-str (time)
  (pcase-let ((`(,h ,m) time))
      (format "%02d:%02d" h m)))

(defun rt-change-on-timer (h m)
  (interactive "nHour: \nnMinute: ")
  (let* ((time-str (time-str (list h m)))
         (five-minute-str (time-str (subtract-time h m 5)))
         (one-minute-str (time-str (subtract-time h m 1))))
    (run-at-time five-minute-str nil 'rt-random-dark-theme)
    (run-at-time one-minute-str nil 'rt-random-light-theme)
    (run-at-time time-str nil 'rt-random-dark-theme)))

(defun add-themes ()
  (map! :leader
        (:prefix "t"
         :desc "Random Doom theme" "s" 'rt-random-doom-theme
         :desc "Theme change on timer" "t" 'rt-change-on-timer
         :desc "Start randomly changing themes" "q" 'rt-start-randomly-changing-theme
         :desc "Stop randomly changing themes" "Q" 'rt-stop-randomly-changing-theme
         :desc "Change theme change frequency" "x" 'rt-change-random-theme-freq
         :desc "Change theme change type" "X" 'rt-change-random-theme-type)))
