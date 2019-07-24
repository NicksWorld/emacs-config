;;; Init.el --- Emacs startup file
;;; Commentary:
;; Does stuff

;;; Code:
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
		    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages"))))
(package-initialize)

(menu-bar-mode    -1)
(tool-bar-mode    -1)
(scroll-bar-mode  -1)
(display-time-mode 1)
(load-theme 'flatland t)

(load "~/.emacs.d/emacs-acronyms")
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-banner-logo-title
      (concat "Welcome to Emacs ("
	      (concat (emacs-random-acronym) ")!")))
(setq dashboard-startup-banner 'logo)
(setq dashboard-items '((recents   . 5)
			(bookmarks . 5)
			(projects  . 5)
			(agenda    . 5)
			(registers . 5)))
(setq dashboard-center-content t)
(setq dashboard-show-shortcuts nil)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(dashboard-modify-heading-icons '((recents . "file-text")
				 (bookmarks . "book")))
(setq dashboard-set-navigator t)
(setq dashboard-navigator-buttons
      `(
	((,""
	  "Homepage"
	  "Browse Homepage"
	  (lambda (&rest _) (browse-url "https://github.com/NicksWorld/emacs-config"))))))


(require 'auto-complete)
(add-hook 'after-change-major-mode-hook (lambda () (unless (memq major-mode
						     (list 'dashboard-mode))
						     (display-line-numbers-mode)
						     (auto-complete-mode))))


(require 'helm)
(require 'helm-config)
(setq helm-exit-idle-delay 0)
(defvar helm-M-x-fuzzy-match t)
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)


(require 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(require 'helm-projectile)
(setq helm-projectile-fuzzy-match t)
(helm-projectile-on)


(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))


(require 'rust-mode)
(setq rust-indent-offset tab-width)
(setq indent-tabs-mode t)
(with-eval-after-load 'rust-mode
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9b35c097a5025d5da1c97dba45fed027e4fb92faecbd2f89c2a79d2d80975181" "2a7beed4f24b15f77160118320123d699282cbf196e0089f113245d4b729ba5d" default)))
 '(package-selected-packages
   (quote
    (flatland-theme helm-projectile helm elcord flycheck-rust rust-mode all-the-icons projectile dashboard))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
