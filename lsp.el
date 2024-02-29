(use-package lsp-ui)
(setq imenu-auto-rescan t)
(setq lsp-ui-imenu-auto-refresh t)

(defun configure-lsp ()
  (map! :leader
	(:prefix ("l" . "lsp")
         :desc "start lsp-ui-imenu" "m" 'lsp-ui-imenu
	 :desc "refresh lsp-ui-imenu" "r" 'lsp-ui-imenu--refresh
	 :desc "find definition" "d" 'lsp-find-definition
	 :desc "find references" "D" 'lsp-find-references
	 :desc "format buffer" "=" 'lsp-format-buffer
	 :desc "organize imports" "o" 'lsp-organize-imports
	 )))
