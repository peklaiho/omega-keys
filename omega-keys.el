;;; Omega-keys minor mode -*- lexical-binding: t -*-
;;; Copyright (c) 2022-2024 Pekka Laiho
;;; License: GNU GPL v3

(defcustom omega-keys-cursor-type t
  "Value for cursor-type when omega-keys is active. If nil then cursor-type is not set by omega-keys.")

(defvar omega-keys-map (make-sparse-keymap)
  "Keymap for omega-keys minor mode.")

(defun omega-keys-enable ()
  "Enable omega-keys-mode if not in minibuffer."
  (interactive)
  (unless (minibufferp)
    (omega-keys-mode 1)))

(defun omega-keys-disable ()
  "Disable omega-keys-mode."
  (interactive)
  (omega-keys-mode 0))

;; Prefix keymaps
(define-prefix-command 'omega-keys-extended-map)
(define-prefix-command 'omega-keys-custom-map)

;; Numeric arguments
(define-key omega-keys-map "0" 'digit-argument)
(define-key omega-keys-map "1" 'digit-argument)
(define-key omega-keys-map "2" 'digit-argument)
(define-key omega-keys-map "3" 'digit-argument)
(define-key omega-keys-map "4" 'digit-argument)
(define-key omega-keys-map "5" 'digit-argument)
(define-key omega-keys-map "6" 'digit-argument)
(define-key omega-keys-map "7" 'digit-argument)
(define-key omega-keys-map "8" 'digit-argument)
(define-key omega-keys-map "9" 'digit-argument)

;; Regular keys
(define-key omega-keys-map "a" 'move-beginning-of-line)
(define-key omega-keys-map "b" 'back-to-indentation)
(define-key omega-keys-map "c" 'omega-keys-custom-map)
(define-key omega-keys-map "d" 'delete-char)
(define-key omega-keys-map "e" 'move-end-of-line)
(define-key omega-keys-map "f" 'omega-keys-disable)
;; g
(define-key omega-keys-map "h" 'backward-delete-char)
(define-key omega-keys-map "i" 'previous-line)
(define-key omega-keys-map "j" 'backward-char)
(define-key omega-keys-map "k" 'next-line)
(define-key omega-keys-map "l" 'forward-char)
(define-key omega-keys-map "m" 'set-mark-command)
(define-key omega-keys-map "n" 'newline)
(define-key omega-keys-map "o" 'other-window)
;; p
(define-key omega-keys-map "q" 'query-replace)
(define-key omega-keys-map "r" 'recenter-top-bottom)
(define-key omega-keys-map "s" 'isearch-forward)
(define-key omega-keys-map "t" 'kill-line)
(define-key omega-keys-map "u" 'universal-argument)
(define-key omega-keys-map "v" 'scroll-up-command)
(define-key omega-keys-map "w" 'kill-region)
(define-key omega-keys-map "x" 'omega-keys-extended-map)
(define-key omega-keys-map "y" 'yank)
;; z

;; Meta keys
(define-key omega-keys-map (kbd "M-a") 'beginning-of-buffer)
(define-key omega-keys-map (kbd "M-b") 'exchange-point-and-mark)
;; M-c is bound to capitalize-word
(define-key omega-keys-map (kbd "M-d") 'kill-word)
(define-key omega-keys-map (kbd "M-e") 'end-of-buffer)
(define-key omega-keys-map (kbd "M-f") 'fill-paragraph)
(define-key omega-keys-map (kbd "M-g") 'goto-line)
(define-key omega-keys-map (kbd "M-h") 'backward-kill-word)
(define-key omega-keys-map (kbd "M-i") 'backward-paragraph)
(define-key omega-keys-map (kbd "M-j") 'backward-word)
(define-key omega-keys-map (kbd "M-k") 'forward-paragraph)
(define-key omega-keys-map (kbd "M-l") 'forward-word)
;; M-m is free (bound to back-to-indentation)
;; M-n is free
;; M-o is free
;; M-p is free
;; M-q is bound to keyboard-quit
;; M-r is bound to move-to-window-line-top-bottom
(define-key omega-keys-map (kbd "M-s") 'isearch-backward)
(define-key omega-keys-map (kbd "M-t") 'transpose-words)
;; M-u is bound to upcase-word
;; M-v is bound to scroll-down-command
;; M-w is bound to kill-ring-save
;; M-x is bound to execute-extended-command
;; M-y is bound to yank-pop
;; M-z is bound to zap-to-char

;; Extended keys
(define-key omega-keys-extended-map "a" 'mark-whole-buffer)
(define-key omega-keys-extended-map "b" (if ido-mode 'ido-switch-buffer 'switch-to-buffer))
;; c
(define-key omega-keys-extended-map "d" (if ido-mode 'ido-dired 'dired))
;; e
(define-key omega-keys-extended-map "f" (if ido-mode 'ido-find-file 'find-file))
;; g
(define-key omega-keys-extended-map "h" 'split-window-horizontally)
;; i
;; j
(define-key omega-keys-extended-map "k" 'kill-this-buffer)
(define-key omega-keys-extended-map "l" 'ibuffer)
;; m
;; n
(define-key omega-keys-extended-map "o" 'delete-other-windows)
(define-key omega-keys-extended-map "p" 'mark-paragraph)
(define-key omega-keys-extended-map "q" 'save-buffers-kill-terminal)
(define-key omega-keys-extended-map "r" (if ido-mode 'ido-find-file-read-only 'find-file-read-only))
(define-key omega-keys-extended-map "s" 'save-buffer)
(define-key omega-keys-extended-map "t" 'delete-window)
(define-key omega-keys-extended-map "u" 'undo)
(define-key omega-keys-extended-map "v" 'split-window-vertically)
(define-key omega-keys-extended-map "w" 'visual-line-mode)
(define-key omega-keys-extended-map "W" 'whitespace-mode)
(define-key omega-keys-extended-map "x" 'recentf-open-files)
;; y
(define-key omega-keys-extended-map "z" 'read-only-mode)

(define-minor-mode omega-keys-mode
  "Customized key bindings for modal editing."
  :lighter " Ω"
  :keymap omega-keys-map
  (when omega-keys-cursor-type
    (setq-local cursor-type
                (if omega-keys-mode
                    omega-keys-cursor-type
                  (default-value 'cursor-type)))))

(defun omega-keys-global-init ()
  "Check if omega-keys should be started in current buffer and start it."
  (unless (minibufferp)
    (omega-keys-mode)))

(define-globalized-minor-mode global-omega-keys-mode
  omega-keys-mode
  omega-keys-global-init)

(provide 'omega-keys)
